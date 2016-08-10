#!/bin/bash

SCRIPTPATH="/opt/oracle/weblogic/12.1.3/binaries/oracle_common/common/bin"
paramCount="$#"

# Set CURRENT_HOME...
CURRENT_HOME=`cd "${SCRIPTPATH}/../.." ; pwd`
export CURRENT_HOME

# Set the MW_HOME relative to the CURRENT_HOME...
MW_HOME=`cd "${CURRENT_HOME}/.." ; pwd`
export MW_HOME

# Set the home directories...
. "${SCRIPTPATH}/setHomeDirs.sh"

# Set the DELEGATE_ORACLE_HOME to CURRENT_HOME if it's not set...
ORACLE_HOME="${DELEGATE_ORACLE_HOME:=${CURRENT_HOME}}"
export DELEGATE_ORACLE_HOME ORACLE_HOME

# Set the directory to get wlst commands from...
COMMON_WLST_HOME="${COMMON_COMPONENTS_HOME}/common/wlst"
WLST_HOME="${COMMON_WLST_HOME}${CLASSPATHSEP}${WLST_HOME}"
export WLST_HOME

# Some scripts in WLST_HOME reference ORACLE_HOME
WLST_PROPERTIES="${WLST_PROPERTIES} -DORACLE_HOME='${ORACLE_HOME}' -DCOMMON_COMPONENTS_HOME='${COMMON_COMPONENTS_HOME}'"
export WLST_PROPERTIES

# Set the WLST extended env...
if [ -f "${COMMON_COMPONENTS_HOME}"/common/bin/setWlstEnv.sh ] ; then
  . "${COMMON_COMPONENTS_HOME}"/common/bin/setWlstEnv.sh
fi

# Appending additional jar files to the CLASSPATH...
if [ -d "${COMMON_WLST_HOME}/lib" ] ; then
  for file in "${COMMON_WLST_HOME}"/lib/*.jar ; do
    CLASSPATH="${CLASSPATH}${CLASSPATHSEP}${file}"
  done
fi

# Appending additional resource bundles to the CLASSPATH...
if [ -d "${COMMON_WLST_HOME}/resources" ] ; then
  for file in "${COMMON_WLST_HOME}"/resources/*.jar ; do
    CLASSPATH="${CLASSPATH}${CLASSPATHSEP}${file}"
  done
fi

export CLASSPATH

umask 027

# set up common environment
if [ ! -z "${WLS_NOT_BRIEF_ENV}" ]; then
  if [ "${WLS_NOT_BRIEF_ENV}" = "true" -o  "${WLS_NOT_BRIEF_ENV}" = "TRUE"  ]; then
    WLS_NOT_BRIEF_ENV=
    export WLS_NOT_BRIEF_ENV
  fi
else
    WLS_NOT_BRIEF_ENV=false
    export WLS_NOT_BRIEF_ENV
fi

if [ -f "${WL_HOME}/server/bin/setWLSEnv.sh" ] ; then
  . "${WL_HOME}/server/bin/setWLSEnv.sh"
else
  . "${MW_HOME}/oracle_common/common/bin/commEnv.sh"
fi

CLASSPATH="${CLASSPATH}${CLASSPATHSEP}${FMWLAUNCH_CLASSPATH}${CLASSPATHSEP}${DERBY_CLASSPATH}${CLASSPATHSEP}${DERBY_TOOLS}"
export CLASSPATH

if [ -f "${SCRIPTPATH}/cam_wlst.sh" ] ; then
  . "${SCRIPTPATH}/cam_wlst.sh"
fi

if [ "${WLST_HOME}" != "" ] ; then
  WLST_PROPERTIES="-Dweblogic.wlstHome='${WLST_HOME}' ${WLST_PROPERTIES}"
  export WLST_PROPERTIES
fi

if [ "${WLS_NOT_BRIEF_ENV}" = "" ] ; then
  echo
  echo CLASSPATH=${CLASSPATH}
fi

#JVM_ARGS="-Dprod.props.file='${WL_HOME}'/.product.properties ${WLST_PROPERTIES} ${JVM_D64} ${UTILS_MEM_ARGS} ${COMMON_JVM_ARGS} ${CONFIG_JVM_ARGS}"

CUSTOMKEYFILELOC="/data/cspd/weblogic12.1.3/domains/cspd_dev_import_manifest/keystores/cspd_dev_import_manifest.jks"
#JVM_ARG1="-Djava.security.egd=file:/dev/./urandom"
JVM_ARG1=""
SSL_ARG1="-Dweblogic.security.SSL.ignoreHostnameVerification=true"
SSL_ARG2="-Dweblogic.security.TrustKeyStore=CustomTrust"
SSL_ARG3="-Dweblogic.security.CustomTrustKeyStoreFileName=keystore/weblogic.jks"
#SSL_ARG4="-Dweblogic.security.CustomTrustKeyStorePassPhrase=weblogic"
SSL_ARG4=""
SSL_ARG5="-Dweblogic.security.SSL.nojce=true"
#SSL_ARG5=""
SSL_ARG6="-Dweblogic.security.SSL.protocolVersion=TLS1"

echo "JAVA HOME=$JAVA_HOME"
echo "CLASSPATH=$CLASSPATH"
echo "WLST PROPERTIES=$WLST_PROPERTIES"
echo "COMMON_WLST_HOME=$COMMON_WLST_HOME"
echo "ORACLE_HOME=$ORACLE_HOME"
echo "MW_HOME=$MW_HOME"
echo "WL_HOME=$WL_HOME"
echo "WLST_HOME=$WLST_HOME"
echo "  * JVM ARG1 = $JVM_ARG1"
echo "  * SSL ARG1 = $SSL_ARG1"
echo "  * SSL ARG2 = $SSL_ARG2"
echo "  * SSL ARG3 = $SSL_ARG3"
echo "  * SSL ARG4 = $SSL_ARG4"
echo "  * SSL ARG5 = $SSL_ARG5"
echo "  * SSL ARG6 = $SSL_ARG6"
echo "  * PY File  = $@"


if [ -d "${JAVA_HOME}" ]; then
   if [ "$paramCount" -lt 1 ]; then
      eval '"${JAVA_HOME}/bin/java"' ${JVM_ARG1} ${SSL_ARG1} ${SSL_ARG2} ${SSL_ARG3} ${SSL_ARG4} ${SSL_ARG5} ${SSL_ARG6} weblogic.WLST
   else
     eval '"${JAVA_HOME}/bin/java"' ${JVM_ARG1} ${SSL_ARG1} ${SSL_ARG2} ${SSL_ARG3} ${SSL_ARG4} ${SSL_ARG5} ${SSL_ARG6} weblogic.WLST '"$@"' $2
   fi
else
 exit 1
fi
