shorewall_ng Cookbook
===========================

Description
-----------

This cookbook enables you to configure a shorewall5 on a debian/ubunto based os a transparent, easy and encapsulated way

[Shorewall](http://shorewall.net/) is a rather comprehensive and easy-to-use abstraction layer on top of iptables.

This cookbook installs, configures and manages Shorewall.

Requirements
------------

#### Chef
Tested on 12 and 15 but newer and older version should work just fine.

#### Platform
The following platforms have been tested with this cookbook, meaning that the recipes run on these platforms without error:
- `Ubuntu`
- `Debian`(8/9/10)

Capabilities
------------

It supports shorewall5, please see the recipes below.

Creates pretty Shorewall configuration files intended to be aesthetically
comparable to hand-written ones.

Recipes
-------

### shorewall_ng::default
This cookbook installs and configures shorewall on the your node. 

### shorewall_ng::shorewall5_jessie_fix
(Yet debian jessie only) Ensure proper sources are added to install the shorewall 5.x package

Attributes
----------

#### shorewall_ng::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['shorewall']['enabled']</tt></td>
    <td>Boolean</td>
    <td>Enable o disable Shorewall</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['shorewall']['default']['options']</tt></td>
    <td>String</td>
    <td>Global start/restart/stop options</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['shorewall']['default']['wait_interface']</tt></td>
    <td>String</td>
    <td>If your Shorewall configuration requires detection of the ip address of a ppp interface, you must list such interfaces in this attribute to get Shorewall to wait until the interface is configured</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['shorewall']['default']['startoptions']</tt></td>
    <td>String</td>
    <td>Start options</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['shorewall']['default']['restartoptions']</tt></td>
    <td>String</td>
    <td>Restart options</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['shorewall']['default']['initlog']</tt></td>
    <td>String</td>
    <td>Init Log. If it is /dev/null, will be used the STARTUP_LOG value defined in shorewall.conf</td>
    <td><tt>/dev/null</tt></td>
  </tr>
  <tr>
    <td><tt>['shorewall']['default']['safestop']</tt></td>
    <td>Numeric</td>
    <td>Set this to 1 to cause '/etc/init.d/shorewall stop' to place the firewall in a safe state rather than to open it</td>
    <td><tt>0</tt></td>
  </tr>
  <tr>
    <td><tt>['shorewall']['zones']</tt></td>
    <td>Array</td>
    <td>This is an array of hashes that contain the zones settings. Each item could have the following keys: <tt>zone</tt>, <tt>type</tt>, <tt>options</tt>, <tt>in_options</tt>, <tt>out_options</tt></td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['shorewall']['policy']</tt></td>
    <td>Array</td>
    <td>This is an array of hashes that contain the polices settings. Each item could have the following keys: <tt>source</tt>, <tt>dest</tt>, <tt>policy</tt>, <tt>log_level</tt>, <tt>limit</tt></td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['shorewall']['interfaces']</tt></td>
    <td>Array</td>
    <td>This is an array of hashes that contain the interfaces settings. Each item could have the following keys: <tt>zone</tt>, <tt>interface</tt>, <tt>broadcast</tt>, <tt>options</tt></td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['shorewall']['hosts']</tt></td>
    <td>Array</td>
    <td>This is an array of hashes that contain the hosts settings. Each item could have the following keys: <tt>zone</tt>, <tt>hosts</tt>, <tt>options</tt></td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['shorewall']['rules']</tt></td>
    <td>Array</td>
    <td>This is an array of hashes that contain the rules settings. Each item could have the following keys: <tt>action</tt>, <tt>source</tt>, <tt>dest</tt>, <tt>proto</tt>, <tt>dest_port</tt>, <tt>source_port</tt>, <tt>original_dest</tt>, <tt>rate_limit</tt>, <tt>user</tt>, <tt>fwmark</tt></td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['shorewall']['tunnels']</tt></td>
    <td>Array</td>
    <td>This is an array of hashes that contain the tunnels settings. Each item could have the following keys: <tt>type</tt>, <tt>zone</tt>, <tt>gateway</tt>, <tt>gateway_zones</tt></td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['shorewall']['masq']</tt></td>
    <td>Array</td>
    <td>This is an array of hashes that contain the masq/SNAT settings. Each item could have the following keys: <tt>interface</tt>, <tt>source</tt>, <tt>address</tt>, <tt>proto</tt>, <tt>ports</tt>, <tt>ipsec</tt>, <tt>mark</tt>, <tt>user</tt>, <tt>switch</tt></td>
    <td><tt>[]</tt></td>
  </tr>
</table>

For more details, see the `attributes/default.rb` file.

Usage
-----

Just include `shorewall_ng` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[shorewall_ng]"
  ]
}
```

You need to set the zones, policies, rules, zones, interfaces in order to manage Shorewall by using this cookbook.

Examples:

- Setting zones:

```json
"shorewall": {
  "zones": [
    { "zone": "fw", "type": "firewall" },
    { "zone": "lan", "type": "ipv4" },
    { "zone": "net", "type": "ipv4" }
  ]
}
```

- Setting policies:

```json
"shorewall": {
  "policy": [
    { "source": "fw", "dest": "all", "policy": "ACCEPT" },
    { "source": "lan", "dest": "fw", "policy": "REJECT", "log": "DEBUG" },
    { "source": "all", "dest": "all", "policy": "REJECT" }
  ]
}
```

- Setting interfaces

```json
"shorewall": {
  "interfaces": [
    { "zone": "net", "interface": "eth0", "broadcast": "detect", "options": "tcpflags,nosmurfs,routefilter,logmartians" },
    { "zone": "lan", "interface": "eth1", "broadcast": "detect", "options": "tcpflags,nosmurfs,routefilter,logmartians" }
  ]
}
```

- Setting rules

```json
"shorewall": {
  "rules": [
    {
      "description": "Don't allow connection pickup from the net",
      "action": "Invalid(DROP)", "source": "net", "dest": "all"
    },
    {
      "description": "Accept DNS connections from the firewall to the network",
      "action": "DNS(ACCEPT)", "source": "fw", "dest": "net"
    },
    {
      "description": "Accept NTP connections from the firewall to the network",
      "action": "NTP(ACCEPT)", "source": "fw", "dest": "net"
    },
    { 
      "description": "Incoming SSH to firewall", 
      "source": "all", "dest": "fw", "proto": "tcp", "dest_port": 22, "action": "ACCEPT" 
    },
    {
      "description": "Accept HTTP/HTTPS connections to internet",
      "action": "Web(ACCEPT)", "source": "fw", "dest": "net"
    },
    {
      "description": "Allow Ping from the local network",
      "action": "Ping(ACCEPT)", "source": "loc", "dest": "fw"
    },
    {
      "description": "Drop Ping from the \"bad\" net zone.. and prevent your log from being flooded..",
      "action": "Ping(DROP)", "source": "net", "dest": "fw"
    },
    {
      "description": "Drop Ping from the \"bad\" net zone.. and prevent your log from being flooded..",
      "action": "ACCEPT", "source": "fw", "dest": "loc", "proto": "icmp"
    },
    {
      "description": "Drop Ping from the \"bad\" net zone.. and prevent your log from being flooded..",
      "action": "ACCEPT", "source": "fw", "dest": "net", "proto": "icmp"
    }
  ]
}
```

- Setting tunnels:

```json
"shorewall": {
  "tunnels": [
    { "type": "ipsec", "zone": "net", "gateway": "0.0.0.0/0", "gateway_zones": "vpn" }
  ]
}  
```

- Setting Masquerade

```json
"shorewall": {
  "masq": [
    { "interface": "eth0", "source": "192.168.0.0/24" }
  ]
}
```

- Setting SNAT

```json
"shorewall": {
  "masq": [
    { "interface": "eth0", "source": "192.168.0.0/24", "address": "1.2.3.4" }
  ]
}
```


Configuration
-------------

The following is a typical example of output (in this case, for a rules file):

    #
    # Shorewall version 5 - Rules File
    #
    # For information on the settings in this file, type "man shorewall-rules"
    #
    # The manpage is also online at
    # http://www.shorewall.net/manpages/shorewall-rules.html
    #
    ############################################################################################################################
    #ACTION         SOURCE          DEST            PROTO   DEST    SOURCE          ORIGINAL        RATE            USER/   MARK
    #                                                       PORT    PORT(S)         DEST            LIMIT           GROUP
    #SECTION ESTABLISHED
    #SECTION RELATED
    SECTION NEW

    # Allow all from VM host
    ACCEPT          net:10.0.2.2    fw              -       -       -               -               -               -       -

    # Incoming SSH to firewall
    ACCEPT          all             fw              tcp     22      -               -               -               -       -

    # Allow database load-balancer db1.vguest access to repmgr monitor
    ACCEPT          lan:192.168.123.10 \
                                    fw              tcp     5480    -               -               -               -       -

Note how line continuations are added as necessary to keep column alignment in place.


Tests
-----

Run the test by using kitchen
```kitchen test```

Contributing
------------

I am very happy to accept this PRs or work on issues to extend the usage of this cookbook.

Just use the [issue queue](https://github.com/EugenMayer/chef-shorewall_ng/issues) or even better, create pull requests for what you like to improve.

# Testing

You can run the test using kitchen

    chef exec kitchen converge
    
There are to test suites, `default` for testing  `shorewall5` to ensure we can install shorewall5 e.g. for docker support.

Credits 
-----------

This cookbook is heavily based on the nowdays no longer maintained cookbook https://github.com/demonccc/chef-shorewall_reloaded - thank you for you hard work Claudio!

License and Authors
-------------------

Author:: Eugen Mayer (eugenmayer on github) 

Old Author:: Claudio Cesar Sanchez Tejeda <demonccc@gmail.com>


Copyright:: 2017, Eugen Mayer

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
