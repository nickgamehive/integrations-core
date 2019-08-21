# Agent Check: mapr

## Overview

This check monitors [mapr][1] through the Datadog Agent.

## Setup

Follow the instructions below to install and configure this check for an Agent running on a host. For containerized environments, see the [Autodiscovery Integration Templates][2] for guidance on applying these instructions.

### Installation

The mapr check is included in the [Datadog Agent][2] package. However, to be able to run it you will need to perform the following steps:

1. Download and extract the [MapR Client][12]
2. Update `LD_LIBRARY_PATH` and `DYLD_LIBRARY_PATH` as explained [here][9] (usually with `/opt/mapr/lib/)`
3. Set `JAVA_HOME` (if running on macos you will need to install system java)
3. Install the [mapr-streams-python][7] library.
4. Create a password for the `dd-agent` user and have this user in every node of the cluster with the same `UID`/`GID` so that it is recognized by mapr. See [Managing users and groups][10].
5. Generate a long-lived (10,000 years by default) token for this user.

### Configuration

1. Edit the `mapr.d/conf.yaml` file, in the `conf.d/` folder at the root of your Agent's configuration directory to start collecting your mapr performance data. See the [sample mapr.d/conf.yaml][3] for all available configuration options.

2. [Restart the Agent][4].

### Validation

[Run the Agent's status subcommand][5] and look for `mapr` under the Checks section.

## Data Collected

### Metrics

mapr does not include any metrics.

### Service Checks

mapr does not include any service checks.

### Events

mapr does not include any events.

### Logs

MapR uses fluentD for logs. You can use [fluentd datadog plugin][11] to collect mapr logs.


## Troubleshooting

Need help? Contact [Datadog support][6].

[1]: **LINK_TO_INTEGRATION_SITE**
[2]: https://docs.datadoghq.com/agent/autodiscovery/integrations
[3]: https://github.com/DataDog/integrations-core/blob/master/mapr/datadog_checks/mapr/data/conf.yaml.example
[4]: https://docs.datadoghq.com/agent/guide/agent-commands/?tab=agentv6#start-stop-and-restart-the-agent
[5]: https://docs.datadoghq.com/agent/guide/agent-commands/?tab=agentv6#agent-status-and-information
[6]: https://docs.datadoghq.com/help
[7]: https://mapr.com/docs/52/MapR_Streams/MapRStreamsPythonExample.html
[8]: https://docs.datadoghq.com/integrations/oracle/
[9]: https://mapr.com/docs/60/MapR_Streams/MapRStreamCAPISetup.html
[10]: https://mapr.com/docs/61/AdministratorGuide/c-managing-users-and-groups.html
[11]: https://www.rubydoc.info/gems/fluent-plugin-datadog
[12]: https://mapr.com/docs/61/AdvancedInstallation/SettingUptheClient-install-mapr-client.html