# -*- coding: utf-8 -*-
# vim: ft=sls

# Defines the content of the message of the day.
/etc/motd:
  file.managed:
    - source:
      - salt://basic-server/motd/motd
    - user: root
    - group: root
    - mode: 0644

# Defines the content of the '/etc/issue' file.
/etc/issue:
  file.managed:
    - source:
      - salt://basic-server/motd/issue
    - user: root
    - group: root
    - mode: 0644

# Defines the content of the '/etc/issue.net' file.
/etc/issue.net:
  file.managed:
    - source:
      - salt://basic-server/motd/issue.net
    - user: root
    - group: root
    - mode: 0644
