# -*- coding: utf-8 -*-
# vim: ft=sls

/etc/motd:
  file.managed:
    - source:
      - salt://basic-server/motd/motd
    - user: root
    - group: root
    - mode: 0644

/etc/issue:
  file.managed:
    - source:
      - salt://basic-server/motd/issue
    - user: root
    - group: root
    - mode: 0644

/etc/issue.net:
  file.managed:
    - source:
      - salt://basic-server/motd/issue.net
    - user: root
    - group: root
    - mode: 0644
