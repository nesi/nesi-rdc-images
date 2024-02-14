=============================================
NeSI OpenStack akl-1 region Configuration
=============================================

This project contains Ansible playbooks and configuration of Images on
an existing OpenStack cloud for the NeSI OpenStack akl-1 region
system.

Preparation
===========

Ensure that Ansible is installed, either via the system package manager or pip.
If required, use a virtualenv to avoid interference with the system python
packages. For example:

.. code-block::

   $ virtualenv venv
   $ source venv/bin/activate
   $ pip install -U pip
   $ pip install -r requirements.txt

Install Ansible role dependencies from Ansible Galaxy:

On macOS you'll need to (re)install the system root CAs into the python virtual env.
.. code-block::

   $ /Applications/Python\ 3.11/Install\ Certificates.command


Install galaxy collections and roles, noting that it will not up- or down-grade any already installed
.. code-block::

   $ ansible-galaxy install \
       -p ansible/roles \
       -r requirements.yml

For the flavor groups playbook, you'll need to first create this directory (will add to playbook code later:Sean) 
.. code-block::
   $ mkdir ./ansible/etc

Usage
=====

First, ensure that OpenStack authentication environment variables are set,
typically by sourcing an OpenStack environment file. If a Kayobe environment
was already configured, you can use the following command:

.. code-block::

   $ source ${KOLLA_CONFIG_PATH}/public-openrc.sh

To build the OpenStack Images:

.. code-block::

   $ tools/nesi_akl1-images.sh --images
