#!/bin/bash

dpkg --get-selections > /home/stavros/.installed_packages/installed_packages.pkg_list
pip list > /home/stavros/.installed_packages/pip_installed_packages.pip_pkg_list

