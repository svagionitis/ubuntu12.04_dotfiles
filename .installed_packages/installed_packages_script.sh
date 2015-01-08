#!/bin/bash

dpkg --get-selections > $HOME/.installed_packages/installed_packages.`date -u +%Y%m%d-%H%M%S`.pkg_list

