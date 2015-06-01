#!/bin/bash

if [ $# != 4 ]; then
  echo -e "ERROR! Wrong number of parameters!"
  echo -e "USE:"
  echo -e "${0} <DSPACEURL> <TOKEN> <REQUEST_DECRIPTOR_FILE> <CONTENT_TYPE [\"json\"/\"xml\"]>"
  exit 1
fi

DSPACEURL=${1}
TOKEN=${2}
REQUEST=${3}
CONTENT_TYPE=${4}

if [ -e ${REQUEST} ]; then
  source $REQUEST
else
  echo "ERROR! Request descriptor file not found!"
  exit 1
fi

case ${CONTENT_TYPE} in
  "json") RQST=${RQST_JSON} ;;
  "xml") RQST=${RQST_XML} ;;
  *) echo -e "ERROR! TYPE MUST BE: \"json\" OR \"xml\"."; exit 1 ;;
esac

curl -k -4 \
  -H "rest-dspace-token: ${TOKEN}" \
  -H "accept: application/${CONTENT_TYPE}" \
  -H "Content-Type: application/${CONTENT_TYPE}" \
	-X ${VERB} "${DSPACEURL}/${ACTION}?${PARAMS}" \
	-T "${FILE}"
