# -*- coding: utf-8 -*-
# vim: ft=sls

# Only the members of the admin group (GID 0) have to be
# allowed to use the command 'su'.
/etc/pam.d/su:
  file.uncomment:
    - regex: auth\s+required\s+pam_wheel\.so
