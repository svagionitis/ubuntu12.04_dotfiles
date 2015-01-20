#!/bin/bash

dpkg --get-selections > /home/stavros/.installed_packages/installed_packages.`date -u +%Y%m%d-%H%M%S`.pkg_list
pip list > /home/stavros/.installed_packages/pip_installed_packages.`date -u +%Y%m%d-%H%M%S`.pip_pkg_list

