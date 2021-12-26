#!/bin/bash
# SPDX-FileCopyrightText: 2021 Kaelan Thijs Fouwels <kaelan.thijs@fouwels.com>
#
# SPDX-License-Identifier: MIT

set -e
SHARE_CONFIG_CUSTOM=/usr/local/tomcat/shared/classes/alfresco/web-extension/share-config-custom.xml

echo "checking supplied environment variables"

if [[ $REPO_HOST == "" ]]; then
    echo "REPO_HOST is not set"
    exit 1
fi
if [[ $REPO_PORT == "" ]]; then
    echo "REPO_PORT is not set"
    exit 1
fi
if [[ $CSRF_FILTER_REFERER == "" ]]; then
    echo "CSRF_FILTER_REFERER is not set"
fi
if [[ $CSRF_FILTER_ORIGIN == "" ]]; then
    echo "CSRF_FILTER_ORIGIN is not set"
fi

echo "environment variables OK"

echo "patching ${SHARE_CONFIG_CUSTOM}"

echo "patching REPO_HOST and REPO_PORT"
sed -i -e 's/REPO_HOST:REPO_PORT/'"$REPO_HOST:$REPO_PORT"'/g' ${SHARE_CONFIG_CUSTOM}

echo "patching CSRF_FILTER_REFERER and CSRF_FILTER_ORIGIN"
sed -i -e "s|<config evaluator=\"string-compare\" condition=\"CSRFPolicy\" replace=\"false\">|<config evaluator=\"string-compare\" condition=\"CSRFPolicy\" replace=\"true\">|" ${SHARE_CONFIG_CUSTOM}
sed -i -e "s|<referer><\/referer>|<referer>$CSRF_FILTER_REFERER<\/referer>|" ${SHARE_CONFIG_CUSTOM}
sed -i -e "s|<origin><\/origin>|<origin>$CSRF_FILTER_ORIGIN<\/origin>|" ${SHARE_CONFIG_CUSTOM}


echo "patching user search ref: https://github.com/Alfresco/acs-community-packaging/issues/367"
sed -i 's/\(<show-authorization-status>\)true\(<\/show-authorization-status\)/\1false\2/' ${SHARE_CONFIG_CUSTOM}

echo "patching miniumum password length"
sed -i 's/\(<password-min-length>\)3\(<\/password-min-length\)/\114\2/' ${SHARE_CONFIG_CUSTOM}

echo "patched ${SHARE_CONFIG_CUSTOM}"

echo "patching styles"
sed -i 's/#f8982b/#4B0096/g' /usr/local/tomcat/webapps/share/components/guest/login.css

echo "dropping to cmd"

"$@"
