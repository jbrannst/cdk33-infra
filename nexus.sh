#persistent nexus
: “${APP_DOMAIN:?Need to set APP_DOMAIN non-empty. Ex rhel-cdk.10.1.2.2.xip.io or apps.openshift.com }”
oc new-project ci
oc new-app -f https://raw.githubusercontent.com/OpenShiftDemos/nexus/master/nexus2-persistent-template.yaml
export MAVEN_MIRROR_URL=http://nexus-ci.$APP_DOMAIN/content/groups/public/
echo MAVEN_MIRROR_URL=http://nexus-ci.$APP_DOMAIN/content/groups/public/
