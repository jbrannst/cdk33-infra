#metrics
: “${APP_DOMAIN:?Need to set APP_DOMAIN non-empty. Ex rhel-cdk.10.1.2.2.xip.io or apps.openshift.com }”
oc project openshift-infra
oc create -f - <<API
apiVersion: v1
kind: ServiceAccount
metadata:
  name: metrics-deployer
secrets:
- name: metrics-deployer
API
oadm policy add-role-to-user     edit system:serviceaccount:openshift-infra:metrics-deployer
oadm policy add-cluster-role-to-user     cluster-reader system:serviceaccount:openshift-infra:heapster
oc secrets new metrics-deployer nothing=/dev/null
oc new-app --as=system:serviceaccount:openshift-infra:metrics-deployer     -f https://raw.githubusercontent.com/openshift/openshift-ansible/master/roles/openshift_hosted_templates/files/v1.3/enterprise/metrics-deployer.yaml -p HAWKULAR_METRICS_HOSTNAME=hawkular-metrics-infra.$APP_DOMAIN  -p USE_PERSISTENT_STORAGE=false
oc new-app --as=system:serviceaccount:openshift-infra:metrics-deployer     -f /Users/anyone/code/openshift-ansible/roles/openshift_hosted_templates/files/v1.3/enterprise/metrics-deployer.yaml -p HAWKULAR_METRICS_HOSTNAME=hawkular-metrics-infra.$APP_DOMAIN  -p USE_PERSISTENT_STORAGE=false -p MODE=validate