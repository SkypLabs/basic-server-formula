# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "basic-server/map.jinja" import password with context %}

# Sets the maximum number of days for which the password
# is valid.
Set max days:
  file.replace:
    - name: /etc/login.defs
    - pattern: '^PASS_MAX_DAYS.*'
    - repl: 'PASS_MAX_DAYS    {{ password.maxdays }}'
    - flags: ['MULTILINE', 'IGNORECASE']
    - append_if_not_found: True

# Sets the minimum number of days after which the user
# must change passwords.
Set min days:
  file.replace:
    - name: /etc/login.defs
    - pattern: '^PASS_MIN_DAYS.*'
    - repl: 'PASS_MIN_DAYS    {{ password.mindays }}'
    - flags: ['MULTILINE', 'IGNORECASE']
    - append_if_not_found: True

# Sets the number of days before the password expiration
# date to warn the user.
Set warn days:
  file.replace:
    - name: /etc/login.defs
    - pattern: '^PASS_WARN_AGE.*'
    - repl: 'PASS_WARN_AGE    {{ password.warndays }}'
    - flags: ['MULTILINE', 'IGNORECASE']
    - append_if_not_found: True

# Sets the minimum acceptable password length.
Set min length:
  file.replace:
    - name: /etc/login.defs
    - pattern: '^PASS_MIN_LEN.*'
    - repl: 'PASS_MIN_LEN     {{ password.minlength}}'
    - flags: ['MULTILINE', 'IGNORECASE']
    - append_if_not_found: True
