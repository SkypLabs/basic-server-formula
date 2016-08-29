# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "basic-server/map.jinja" import admin with context %}
{% from "basic-server/map.jinja" import password with context %}

admin:
  user.present:
    - name: {{ admin.name }}
    - shell: {{ admin.shell }}
    - uid: {{ admin.uid }}
    - gid: {{ admin.gid }}
    - groups:
      - {{ admin.system_admin_group }}
    - createhome: {{ admin.createhome }}
    - home: {{ admin.home }}
    - password: {{ admin.password }}
    - enforce_password: {{ admin.enforce_password }}
    - mindays: {{ password.mindays }}
    - maxdays: {{ password.maxdays }}
    - warndays: {{ password.warndays }}
