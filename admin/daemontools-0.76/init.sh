#!/bin/bash
touch linkedsee_svscan.conf
COMMAND=$(pwd)/command/
echo -e  "#!/bin/sh \n" > ./linkedsee_svscan.conf
echo "PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:$COMMAND " >> ./linkedsee_svscan.conf

echo "exec < /dev/null" >> ./linkedsee_svscan.conf
echo  >> ./linkedsee_svscan.conf
echo "exec > /dev/null" >> ./linkedsee_svscan.conf
echo -e "exec 2> /dev/null">> ./linkedsee_svscan.conf
echo  >> ./linkedsee_svscan.conf
echo "svc -dx ${COMMAND}/services/* ${COMMAND}/services/*/log" >> ./linkedsee_svscan.conf
echo  >> ./linkedsee_svscan.conf
echo "env - PATH='\$PATH' svscan ${COMMAND}/service 2>&1 | \\" >> ./linkedsee_svscan.conf
echo  >> ./linkedsee_svscan.conf
echo "env - PATH='\$PATH' readproctitle service errors: ................................................................................................................................................................................................................................................................................................................................................................................................................ " >> ./linkedsee_svscan.conf

