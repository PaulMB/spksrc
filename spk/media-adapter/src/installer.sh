#!/bin/sh

preinst ()
{
    source /etc/profile

    if [ -z ${JAVA_HOME} ]; then
        echo "A configuration problem has been detected. JAVA_HOME is not defined." > $SYNOPKG_TEMP_LOGFILE
        exit 1
    fi

    if [ ! -f ${JAVA_HOME}/bin/java ]; then
        echo "A configuration problem has been detected. Could not find Java binary." > $SYNOPKG_TEMP_LOGFILE
        exit 1
    fi
}

postinst ()
{
    ln -s ${SYNOPKG_PKGDEST}/app /usr/syno/synoman/webman/3rdparty/MediaAdapter
    ln -s ${SYNOPKG_PKGDEST}/etc/Media.Adapter.legacy.conf /etc/httpd/sites-enabled/
    mkdir -p ${SYNOPKG_PKGDEST}/lib ${SYNOPKG_PKGDEST}/var/tmp ${SYNOPKG_PKGDEST}/var/log ${SYNOPKG_PKGDEST}/var/run
    chown -R admin.users ${SYNOPKG_PKGDEST}
    # Required to enable mod_proxy
    sleep 5 && /usr/syno/etc.defaults/rc.d/S97apache-sys.sh restart &
    exit 0
}

preuninst ()
{
    exit 0
}

postuninst ()
{
    rm -f /usr/syno/synoman/webman/3rdparty/MediaAdapter
    rm -f /etc/httpd/sites-enabled/Media.Adapter.legacy.conf
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
