#!/bin/ash
# SPDX-FileCopyrightText: 2021 Kaelan Thijs Fouwels <kaelan.thijs@fouwels.com>
#
# SPDX-License-Identifier: MIT

set -e

echo "| entering entrypoint"

KEY_PATH=/keys

echo "| checking for existing keys"
if [ ! -f $KEY_PATH/privkey.pem ]; then
	echo "| $KEY_PATH/privkey.pem not found, generating dummy certificates"
	/usr/bin/openssl req -x509 -nodes -newkey rsa:3072 -days 1 -keyout "$KEY_PATH/privkey.pem" -out "$KEY_PATH/fullchain.pem" -subj '/CN=dummy.local'
else
	echo "| keys found, not generating dummy certificates"
fi

echo "| exiting entrypoint, handing off to cmd"

"$@"
