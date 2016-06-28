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
echo -e  "#!/bin/sh \n" > ${ROOT_DIR}/linkedsee_svscan.conf
echo "PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:$COMMAND " >> ${ROOT_DIR}/linkedsee_svscan.conf

echo "exec < /dev/null" >> ${ROOT_DIR}/linkedsee_svscan.conf
echo  >> ${ROOT_DIR}/linkedsee_svscan.conf
echo "exec > /dev/null" >> ${ROOT_DIR}/linkedsee_svscan.conf
echo -e "exec 2> /dev/null">> ${ROOT_DIR}/linkedsee_svscan.conf
echo  >> ${ROOT_DIR}/linkedsee_svscan.conf
echo "svc -dx ${COMMAND}/services/* ${COMMAND}/services/*/log" >> ${ROOT_DIR}/linkedsee_svscan.conf
echo  >> ${ROOT_DIR}/linkedsee_svscan.conf
echo "env - PATH='\$PATH' svscan ${COMMAND}/service 2>&1 | \\" >> ${ROOT_DIR}/linkedsee_svscan.conf
echo  >> ${ROOT_DIR}/linkedsee_svscan.conf
echo "env - PATH='\$PATH' readproctitle service errors: ................................................................................................................................................................................................................................................................................................................................................................................................................ " >> ${ROOT_DIR}/linkedsee_svscan.conf

