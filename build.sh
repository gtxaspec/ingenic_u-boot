#!/bin/bash

if command -v ccache &> /dev/null; then
	CROSS_COMPILE="${CROSS_COMPILE:-ccache mipsel-linux-}"
	HOSTCC="${HOSTCC:-ccache gcc}"
else
	CROSS_COMPILE="${CROSS_COMPILE:-mipsel-linux-}"
	HOSTCC="${HOSTCC:-gcc}"
fi

OUTPUT_DIR="./uboot_build"

if command -v resize; then
	eval $(resize)
	size="$(( LINES - 4 )) $(( COLUMNS -4 )) $(( LINES - 12 ))"
else
	size="20 76 12"
fi

pick_a_soc() {
	eval `resize`
	soc=$(whiptail --title "U-Boot SoC selection" \
		--menu "Choose a SoC model" $size \
		"isvp_t40n_sfcnor"		"Ingenic T40N"		\
		"isvp_t40xp_sfcnor"		"Ingenic T40XP"		\
		"isvp_t40xp_msc0"		"Ingenic T40XP MSC0"		\
		"isvp_t40n_msc0"		"Ingenic T40N MSC0"		\
		--notags 3>&1 1>&2 2>&3)
}

# Function to build a specific version
build_version() {
	# Start timer
	SECONDS=0

	local soc=$1
	echo "Building U-Boot for ${soc}"

	make distclean
	mkdir -p "${OUTPUT_DIR}" >/dev/null
	make CROSS_COMPILE="$CROSS_COMPILE" $soc -j$(nproc) HOSTCC="$HOSTCC"
	if [ -f u-boot-lzo-with-spl.bin ]; then
		echo "u-boot-lzo-with-spl.bin exists, copying..."
		cp u-boot-lzo-with-spl.bin "${OUTPUT_DIR}/u-boot-${soc}.bin"
	elif [ -f u-boot-with-spl.bin ]; then
		echo "u-boot-with-spl.bin exists, copying..."
		cp u-boot-with-spl.bin "${OUTPUT_DIR}/u-boot-${soc}.bin"
	fi
}

soc="$1"
[ -z "$soc" ] && pick_a_soc
[ -z "$soc" ] && echo No SoC && exit 1
build_version "$soc"

# End timer and report
duration=$SECONDS
echo "Done"
echo "Total build time: $(($duration / 60)) minutes and $(($duration % 60)) seconds."
exit 0
