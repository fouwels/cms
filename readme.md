<!--
SPDX-FileCopyrightText: 2021 Kaelan Thijs Fouwels <kaelan.thijs@fouwels.com>

SPDX-License-Identifier: MIT
-->
# ACS CMS

Production [compose/spec](https://github.com/compose-spec/compose-spec/blob/master/spec.md) deployment for an Alfresco CE system.

Deployable on ECS, ACI, or dockerd via [compose/cli](https://github.com/docker/compose) (go)

Stacks up the Alfresco CE CMS system with postgres, caddy, Apache Solr, and the ACS 7 T-Engines.

Overrides a number of default alfresco entrypoints/configurations, for various... reasons. See the specific file descriptors.

Implements:
- https://cms.fouwels.com

## License
MIT and/or MIT compatible

Licensing tracked via SPDX, see file level tags for specific attribution

*Professional YAML engineering*