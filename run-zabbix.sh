# check if podman is installed
echo "Checking for podman..."
podman pod stop zabbix 2>/dev/null || true
if podman pod exists zabbix; then
  podman pod rm -f zabbix
fi

# create from kube yaml
echo "Creating Zabbix pod from kube yaml..."
podman play kube ./zabbix.yaml