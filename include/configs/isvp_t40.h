/*
 * Ingenic isvp T40 configuration
 *
 * Copyright (c) 2020 Ingenic Semiconductor Co.,Ltd
 * Author: Matthew <tong.yu@ingenic.com>
 * Based on: include/configs/urboard.h
 *           Written by Paul Burton <paul.burton@imgtec.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */

#ifndef __CONFIG_ISVP_T40_H__
#define __CONFIG_ISVP_T40_H__

#include "isvp_common.h"

/**
 * Boot arguments definitions.
 */
#define BOOTARGS_COMMON "mem=\\${osmem} rmem=\\${rmem}"
#if defined(CONFIG_DDR_128M) || defined(CONFIG_DDR_256M)
#define CONFIG_EXTRA_SETTINGS \
"osmem=99M@0x0\0" \
"rmem=29M@0x6300000\0"
#else
#define CONFIG_EXTRA_SETTINGS \
"osmem=42M@0x0\0" \
"rmem=22M@0x2a00000\0"
#endif

/*
	Platform Default GPIOs
	These shall be specific to the SoC model
*/

#define CONFIG_GPIO_SETTINGS \
"gpio_default=\0" \
"gpio_default_net=\0"


#endif /* __CONFIG_ISVP_T40_H__ */
