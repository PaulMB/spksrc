#!/bin/sh

source /etc/profile

ADAPTER_JAVA=${JAVA_HOME}/bin/java
ADAPTER_PID=${SYNOPKG_PKGDEST}/var/run/media-adapter.pid
ADAPTER_LOG=${SYNOPKG_PKGDEST}/var/log/media-adapter.log
ADAPTER_PORT=`cat ${SYNOPKG_PKGDEST}/etc/http.conf | sed '/^port */!d; s///;q'`

running() {
    local PID=`cat "$1" 2>/dev/null` || return 1
    kill -0 "$PID" 2>/dev/null
}

case $1 in
	start)
	    nohup ${ADAPTER_JAVA} -Xmx48m -jar ${SYNOPKG_PKGDEST}/lib/media-adapter-rest-0.1.jar -port ${ADAPTER_PORT} -config ${SYNOPKG_PKGDEST}/etc/media-adapter.xml > ${ADAPTER_LOG} 2>&1 &
	    echo $! > ${ADAPTER_PID}
		exit 0
	;;
	stop)
        kill -TERM `cat ${ADAPTER_PID}`
		exit 0
	;;
	status)
	    if [ -f ${ADAPTER_PID} ]; then
            if running ${ADAPTER_PID}; then
                exit 0
            else
                rm -f ${ADAPTER_PID}
                exit 1
            fi
        else
            exit 3
        fi
	;;
	log)
	    echo ${ADAPTER_LOG}
		exit 0
	;;
esac
                                     
