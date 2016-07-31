# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "basic-server/map.jinja" import sysctl with context %}

{% if salt['file.file_exists']('/proc/sys/kernel/exec-shield') %}
kernel.exec-shield:
  sysctl.present:
    - value: {{ sysctl.exec_shield }}
{% endif %}

kernel.randomize_va_space:
  sysctl.present:
    - value: {{ sysctl.randomize_va_space }}
