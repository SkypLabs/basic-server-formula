# -*- coding: utf-8 -*-
# vim: ft=sls

# Only the root user needs to access to this file.
/boot/grub2/grub.cfg:
  file.managed:
    - user: root
    - group: root
    - mode: 0600

# Ensures that nobody can disable the security-related
# services during an interactive startup and so gain
# access to the system.
Disabling interactive startup:
  file.replace:
    - name: /etc/sysconfig/init
    - pattern: '^PROMPT=no'
    - repl: 'PROMPT=no'
    - flags: ['MULTILINE', 'IGNORECASE']
    - append_if_not_found: True
