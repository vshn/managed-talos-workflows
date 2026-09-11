Given I have all prerequisites installed
And a Lieutenant cluster
And a Keycloak service
And a cloudscale API token
And basic cluster information
Then I set up a cloudscale private network
And I set up a subnet in the cloudscale private network
And I provision a router for the new network
And I allocate a cloudscale floating IP for the Talos cluster's Kubernetes API and Ingress
And I configure DNS records for the cluster API, ingress, and egress
Then I create a cloudscale objects user and S3 buckets for the cluster
And I set secrets in Vault
Then I render the Talos schematic UUID
And I generate the Talos image and upload it to cloudscale
And I configure the Talos cluster via Project Syn
Then I set up a Kind cluster
And I set up an SSH jumphost in the cluster network
And I wait for the jumphost to become ready
And I set up a SOCKS5 proxy via the SSH jumphost on the Kind cluster's gateway IP
And I install cluster API in the Kind cluster
And I create the cluster via cluster API
And wait for the Talos cluster to become ready
Then I bootstrap the cluster API providers on the Talos cluster
And I move the cluster API cluster to the Talos cluster
And delete the Kind cluster
Then I synthesize the cluster
And I wait until all ArgoCD apps are synced and healthy
