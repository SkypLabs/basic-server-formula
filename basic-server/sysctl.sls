# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "basic-server/map.jinja" import sysctl with context %}

# If the hardware doesn't implement the NX protection
{% if salt['file.file_exists']('/proc/sys/kernel/exec-shield') %}
# https://en.wikipedia.org/wiki/Exec_Shield
kernel.exec-shield:
  sysctl.present:
    - value: {{ sysctl.exec_shield }}
{% endif %}

# https://en.wikipedia.org/wiki/Address_space_layout_randomization
# Values :
# 0 : No randomization. Everything is static.
# 1 : Conservative randomization. Shared libraries, stack, mmap(), VDSO and heap are randomized.
# 2 : Full randomization. In addition to elements listed in the previous point, memory managed through brk() is also randomized.
kernel.randomize_va_space:
  sysctl.present:
    - value: {{ sysctl.randomize_va_space }}
