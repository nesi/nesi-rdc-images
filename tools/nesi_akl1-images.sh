#!/bin/sh
TEMP=`getopt --options p:ich --longoptions project:,images,config,help -- "$@"`
eval set -- "$TEMP"

PLAYBOOK=''
_IMAGES=0
_CONFIG=0
_HELP=1
while true ; do
    case "$1" in
        -p| --playbook)
            PLAYBOOK=$2; _HELP=0 ; shift 2 ;;
        -i| --images)
            _IMAGES=1 ; _HELP=0 ; shift 1 ;;
        -c| --config)
            _CONFIG=1 ; _HELP=0 ; shift 1 ;;
	    -h| --help) shift 1 ;;
        --) shift ; break ;;
	*) echo "Unknown option $1 ignored" ; shift 1;;
    esac
done
if [ _HELP ]; then
    echo "Usage:"
    echo "   nesi_akl1-manage-config.sh [options]"
    echo "   -p|--playbook <playbook name> : use playbook "
    echo "   -i|--images                   : build nesi images, playbook is set to nesi_akl1-images.yml"
    echo "   -c|--config                   : run playbook with nesi config"
    echo "   -h|--help                     : display this message"
fi

echo "Images         : ${_IMAGES}"
echo "Config         : ${_CONFIG}"

if [ $_IMAGES -eq 1 ]; then
  echo "ansible-playbook ./ansible/nesi_akl1-images.yml -i ansible/inventory -e @etc/nesi_akl1-config/nesi_akl1-images.yml"
  ansible-playbook ./ansible/nesi_akl1-images.yml -i ansible/inventory -e @etc/nesi_akl1-config/nesi_akl1-images.yml
fi
if [ $_CONFIG -eq 1 ]; then
  echo "ansible-playbook ${PLAYBOOK} -i ansible/inventory -e @etc/nesi_akl1-config/nesi_akl1-config.yml"
  ansible-playbook ${PLAYBOOK} -i ansible/inventory -e @etc/nesi_akl1-config/nesi_akl1-config.yml
fi