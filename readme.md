<!--
SPDX-FileCopyrightText: 2021 Kaelan Thijs Fouwels <kaelan.thijs@fouwels.com>

SPDX-License-Identifier: MIT
-->

Production [compose/spec](https://github.com/compose-spec/compose-spec/blob/master/spec.md) deployment for the an alfresco CMS system.


Deployable with V2 of the docker [compose cli](https://github.com/docker/compose-cli)

Based on the alfresco cms, postgres, nginx, and lets-encrypt/acme for certificate management.

Overrides a number of default alfresco entrypoints/configurations, for various reasons.

Used for cms.fouwels.com

-Professional YAML engineering