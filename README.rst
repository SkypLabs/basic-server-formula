====================
basic-server-formula
====================

A saltstack formula to setup the basic settings on a new server.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``basic-server``
------------

Applies the following states :

- basic-server.admin-user
- basic-server.pam-su-root

``basic-server.admin-user``
------------

Creates an admin user.

``basic-server.pam-su-root``
------------

Ensures that only the members of the admin group (GID 0) are allowed to use the command 'su'.
