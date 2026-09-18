Given I have all the tools required to upload a Talos image to cloudscale
And I select the target cluster
And I compile the cluster catalog
And I extract the Talos schematic UUID from the cluster config
And I select a target Talos and Kubernetes version
And I create a bootstrap bucket
And I generate the Talos image and upload it to cloudscale
And I delete the bootstrap bucket
Then I update the cluster to use the new Talos version and image
And I compile and push the cluster catalog
And I trigger a refresh of the talos-capi-cluster-cloudscale ArgoCD app
