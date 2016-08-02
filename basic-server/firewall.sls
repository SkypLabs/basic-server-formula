# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "basic-server/map.jinja" import basic_server with context %}
{% from "basic-server/map.jinja" import firewall with context %}

disable firewalld:
  service.dead:
    - name: firewalld
    - enable: False

flush input:
  iptables.flush:
    - table: INPUT

flush forward:
  iptables.flush:
    - table: FORWARD

flush output:
  iptables.flush:
    - table: OUTPUT

default policy input:
  iptables.set_policy:
    - chain: INPUT
    - policy: {{ firewall.default_policy_input }}

default policy forward:
  iptables.set_policy:
    - chain: FORWARD
{% if basic_server.router %}
    - policy: ACCEPT
{% else %}
    - policy: {{ firewall.default_policy_forward }}
{% endif %}

default policy output:
  iptables.set_policy:
    - chain: OUTPUT
    - policy: {{ firewall.default_policy_output }}

allow established and related:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - match:
      - state
    - connstate: ESTABLISHED,RELATED
    - save: True

allow ICMP:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - protocol: icmp
    - save: True

allow loopback:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - in-interface: lo
    - save: True

allow SSH:
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

{% if firewall.salt_minion %}
allow salt minion:
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
