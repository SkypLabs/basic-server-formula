# -*- coding: utf-8 -*-
# vim: ft=sls

/etc/pam.d/su:
  file.uncomment:
    - regex: auth\s+required\s+pam_wheel\.so
