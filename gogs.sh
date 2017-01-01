# persistent gogs with configmap
: “${APP_DOMAIN:?Need to set APP_DOMAIN non-empty. Ex rhel-cdk.10.1.2.2.xip.io or apps.openshift.com }”
oc project ci
oc new-app -f https://raw.githubusercontent.com/OpenShiftDemos/gogs-openshift-docker/master/openshift/gogs-persistent-template.yaml --param=HOSTNAME=gogs-ci.$APP_DOMAIN
