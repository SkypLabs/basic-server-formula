====================
basic-server-formula
====================

A `SaltStack <https://saltstack.com/>`_ formula to setup the basic settings on a new server.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``basic-server``
----------------

Runs all the states of this formula.

``basic-server.admin-user``
---------------------------

Creates an admin user.

``basic-server.firewall``
-------------------------

Sets up a basic firewall configuration.

``basic-server.motd``
---------------------

Sets up the message of the day.

``basic-server.pam-su-root``
----------------------------

Ensures that only the members of the admin group (GID 0) are allowed to use the command 'su'.

``basic-server.sysctl``
-----------------------

Ensures that the kernel is well configured in order to improve its security and optimize its performances.
