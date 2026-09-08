Given I have all prerequisites installed
And I select the cluster to decommission
And I extract the cloudscale API token from the cluster
Then I confirm cluster deletion
Then I set up a Kind cluster
And I fetch the cluster's subnet from the cloudscale API
And I set up an SSH jumphost in the cluster network
And I wait for the jumphost to become ready
And I set up a SOCKS5 proxy via the SSH jumphost on the Kind cluster's gateway IP
And I install cluster API in the Kind cluster
Then I disable ArgoCD on the cluster
And I move the Talos cluster to the Kind cluster
Then I delete all pods
And I delete all Load Balancer services
And I delete all Persistent Volumes
Then I delete the Talos cluster via Cluster API
And delete the Kind cluster
Then I delete the jumphost
And I delete the cloudscale floating IPs
And I delete the cloudscale router
And I delete the cloudscale subnet and private network
And I delete the cloudscale S3 buckets
And I delete the cluster backups and cloudscale objects user
And I delete the cluster's API token
Then I delete the cluster's Vault secrets
And I delete the cluster from Lieutenant
And I delete the Keycloak service
