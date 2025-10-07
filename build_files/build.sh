#!/bin/bash

set -ouex pipefail

dnf update

# install latest vanilla kernel

dnf -y copr enable @kernel-vanilla/stable
dnf upgrade 'kernel*'
dnf -y copr disable @kernel-vanilla/stable

# set kernel parameters to fix keyboard after suspend

grubby --update-kernel=ALL --args="i8042.reset i8042.nomux i8042.nopnp i8042.noloop"

# install tuxedo control center

rpm --import 0x54840598.pub.asc

mv tuxedo.repo /etc/yum.repos.d/tuxedo.repo

dnf install tuxedo-control-center

# install ethernet driver

rpm install -y tuxedo-yt6801-1.0.28-1.noarch.rpm
