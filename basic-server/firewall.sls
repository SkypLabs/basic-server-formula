# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "basic-server/map.jinja" import basic_server with context %}
{% from "basic-server/map.jinja" import firewall with context %}

# If firewalld is installed and we want to use it.
{% if salt['pkg.installed']('firewalld') and basic_server.firewalld %}
# Ensures that firewalld is enabled and running.
Enable firewalld:
  service.running:
    - name: firewalld
    - enable: True

# Sets the default zone.
Set default zone:
  firewalld.present:
    - name: {{ firewall.firewalld_default_zone }}
    - block_icmp: False
    - default: True
    - masquerade: False
    - ports:
# If we want to use the Salt agent.
{% if firewall.salt_minion %}
      - 4505/tcp
      - 4506/tcp
{% endif %}
# If we don't use the default SSH port.
{% if firewall.ssh_port != 22 %}
      - {{ firewall.ssh_port }}/tcp
{% else %}
    - services:
      - ssh
{% endif %}
  cmd.run:
    - name: firewall-cmd --reload
{% else %}
# Ensures that firewalld is disabled and not running.
Disable firewalld:
  service.dead:
    - name: firewalld
    - enable: False

# Flushes the input chain.
Flush input:
  iptables.flush:
    - table: INPUT

# Flushes the forward chain.
Flush forward:
  iptables.flush:
    - table: FORWARD

# Flushes the output chain.
Flush output:
  iptables.flush:
    - table: OUTPUT

# Sets the default input chain policy.
Default policy input:
  iptables.set_policy:
    - chain: INPUT
    - policy: {{ firewall.default_policy_input }}

# Sets the default forward chain policy.
Default policy forward:
  iptables.set_policy:
    - chain: FORWARD
# If the server should act as a router.
{% if basic_server.router %}
    - policy: ACCEPT
{% else %}
    - policy: {{ firewall.default_policy_forward }}
{% endif %}

# Sets the default output chain policy.
Default policy output:
  iptables.set_policy:
    - chain: OUTPUT
    - policy: {{ firewall.default_policy_output }}

# Allows incoming stateful connections.
Allow established and related:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - match:
      - state
    - connstate: ESTABLISHED,RELATED
    - save: True

# Allows incoming ICMP packets.
Allow ICMP:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - protocol: icmp
    - save: True

# Allows incoming connections on the loopback interface.
Allow loopback:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - in-interface: lo
    - save: True

# Allows incoming SSH connections.
Allow SSH:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - match:
      - state
    - connstate: NEW
    - proto: tcp
    - dport: {{ firewall.ssh_port }}
    - save: True

# If we want to use the Salt agent.
{% if firewall.salt_minion %}
# Allows incoming connections from the Salt master.
Allow salt minion:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - match:
      - state
    - connstate: NEW
    - proto: tcp
    - dports: 4505,4506
    - save: True
{% endif %}
{% endif %}
