# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "basic-server/map.jinja" import basic_server with context %}
{% from "basic-server/map.jinja" import sysctl with context %}

## Kernel hardening
## See https://www.kernel.org/doc/Documentation/sysctl/kernel.txt

# If the hardware doesn't implement the NX protection.
{% if salt['file.file_exists']('/proc/sys/kernel/exec-shield') %}
# Exec Shield protection.
kernel.exec-shield:
  sysctl.present:
    - value: {{ sysctl.exec_shield }}
{% endif %}

# ASLR.
kernel.randomize_va_space:
  sysctl.present:
    - value: {{ sysctl.randomize_va_space }}

# Restricting access to kernel logs.
kernel.dmesg_restrict:
  sysctl.present:
    - value: {{ sysctl.dmesg_restrict }}

## Networking parameters
## See https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt

# Source route verification.
net.ipv4.conf.all.rp_filter:
  sysctl.present:
    - value: {{ sysctl.rp_filter }}
net.ipv4.conf.default.rp_filter:
  sysctl.present:
    - value: {{ sysctl.rp_filter }}

# TCP syncookies (prevents against the common 'SYN flood attack').
net.ipv4.tcp_syncookies:
  sysctl.present:
    - value: {{ sysctl.tcp_syncookies }}

# If the server has to ignore the ICMP ECHO and TIMESTAMP requests
# sent to it via broadcast/multicast.
net.ipv4.icmp_echo_ignore_broadcasts:
  sysctl.present:
    - value: {{ sysctl.icmp_echo_ignore_broadcasts }}

# If the server has to log the packets with impossible addresses
# to kernel log.
net.ipv4.conf.all.log_martians:
  sysctl.present:
    - value: {{ sysctl.log_martians }}
net.ipv4.conf.default.log_martians:
  sysctl.present:
    - value: {{ sysctl.log_martians }}

# If the server has to act as a router.
{% if basic_server.router %}
{% set ip_forward = 1 %}
{% set send_redirects = 1 %}
{% set accept_redirects = 1 %}
{% set secure_redirects = 1 %}
{% set accept_source_route = 1 %}
{% else %}
{% set ip_forward = 0 %}
{% set send_redirects = 0 %}
{% set accept_redirects = 0 %}
{% set secure_redirects = 0 %}
{% set accept_source_route = 0 %}
{% endif %}

# IP forwarding.
net.ipv4.ip_forward:
  sysctl.present:
    - value: {{ ip_forward }}

# Send redirects.
net.ipv4.conf.all.send_redirects:
  sysctl.present:
    - value: {{ send_redirects }}
net.ipv4.conf.default.send_redirects:
  sysctl.present:
    - value: {{ send_redirects }}

# Accept redirects.
net.ipv4.conf.all.accept_redirects:
  sysctl.present:
    - value: {{ accept_redirects }}
net.ipv4.conf.default.accept_redirects:
  sysctl.present:
    - value: {{ accept_redirects }}

# Secure redirects.
net.ipv4.conf.all.secure_redirects:
  sysctl.present:
    - value: {{ secure_redirects }}
net.ipv4.conf.default.secure_redirects:
  sysctl.present:
    - value: {{ secure_redirects }}

# Accept packets with SRR option.
net.ipv4.conf.all.accept_source_route:
  sysctl.present:
    - value: {{ accept_source_route }}
net.ipv4.conf.default.accept_source_route:
  sysctl.present:
    - value: {{ accept_source_route}}
