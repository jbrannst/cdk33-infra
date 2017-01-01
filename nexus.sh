#persistent nexus
: “${APP_DOMAIN:?Need to set APP_DOMAIN non-empty. Ex rhel-cdk.10.1.2.2.xip.io or apps.openshift.com }”
oc new-project ci
new-app sonatype/nexus
expose svc/nexus
oc set probe dc/nexus --liveness --failure-threshold 3 --initial-delay-seconds 30 -- echo ok
oc set probe dc/nexus --readiness --failure-threshold 3 --initial-delay-seconds 30 --get-url=http://nexus-ci./content/groups/public
oc volumes dc/nexus --add --name 'nexus-volume-1' --type 'pvc' --mount-path '/sonatype-work/' --claim-name 'nexus-pv' --claim-size '1G' --overwrite
export MAVEN_MIRROR_URL=http://nexus-ci.$APP_DOMAIN/nexus/content/groups/public/