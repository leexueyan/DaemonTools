#!/bin/bash

if [ "$0" = "bash" ]; then
  cd "$(dirname "$BASH_SOURCE")"
  CUR_FILE=$(pwd)/$(basename "$BASH_SOURCE")
  SELF_ABS=$(dirname "$CUR_FILE")
  cd - > /dev/null
else
  echo "$0" | grep -q "$PWD"
  if [ $? -eq 0 ]; then
    CUR_FILE=$0
  else
    CUR_FILE=$(pwd)/$0
  fi
  SELF_ABS=$(dirname "$CUR_FILE")
fi

ROOT_DIR=${SELF_ABS}
COMMAND=${ROOT_DIR}/command/
#根据路径写svscanboot
echo "#!/bin/sh" > ${COMMAND}/svscanboot
echo "PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:$COMMAND " >> ${COMMAND}/svscanboot

echo "exec < /dev/null" >> ${COMMAND}/svscanboot
echo "exec > /dev/null" >> ${COMMAND}/svscanboot
echo -e "exec 2> /dev/null">> ${COMMAND}/svscanboot
echo  >> ${COMMAND}/svscanboot
echo "${COMMAND}/svc -dx ${ROOT_DIR}/services/* ${ROOT_DIR}/services/*/log" >> ${COMMAND}/svscanboot
echo  >> ${COMMAND}/svscanboot
echo "env - PATH=\$PATH ${COMMAND}/svscan ${ROOT_DIR}/service 2>&1 | \\" >> ${COMMAND}/svscanboot
echo  >> ${COMMAND}/svscanboot
echo "env - PATH='\$PATH' readproctitle service errors: ................................................................................................................................................................................................................................................................................................................................................................................................................ " >> ${COMMAND}/svscanboot

if [ -d /etc/init ];then
  cp -f ${COMMAND}/svscanboot /etc/init/
fi

#写linkedsee_svscan监护程序(由init进程监控)
echo "start on runlevel [345]" > /etc/init/linkedsee_svscan.conf
echo "respawn" >> /etc/init/linkedsee_svscan.conf
echo "exec ${ROOT_DIR}/command/svscanboot" >> /etc/init/linkedsee_svscan.conf


