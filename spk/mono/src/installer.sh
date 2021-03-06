#!/bin/sh

# Package
PACKAGE="mono"
DNAME="Mono"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
PATH="${INSTALL_DIR}/bin:${PATH}"
INSTALL_LOG="${INSTALL_DIR}/var/install.log"

preinst ()
{
   	exit 0
}

postinst ()
{

	# Link
	ln -s ${SYNOPKG_PKGDEST} ${INSTALL_DIR}

    	# Complete installation items & log
	echo " -- || Mono Installed | $(date) | Version Info: || -- " >> ${INSTALL_LOG}
    	${INSTALL_DIR}/bin/mono -V >> ${INSTALL_LOG} 2>&1

    	# Correct the files ownership
    	chown -R ${USER}:root ${SYNOPKG_PKGDEST}

    	exit 0
}

preuninst ()
{
    	# Remove link
    	rm -f ${INSTALL_DIR}

    	exit 0
}

postuninst ()
{
    	exit 0
}

preupgrade ()
{

    	exit 0
}

postupgrade ()
{

    	exit 0
}


