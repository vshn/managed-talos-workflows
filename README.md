# managed-talos-workflows

VSHN Managed Talos wizards implemented as [Gandalf](https://github.com/appuio/gandalf) workflows.

See the [VSHN Managed Talos knowledge base](https://kb.vshn.ch/talos) for how-tos that utilize the workflows in this repository.

> [!WARNING]
> This repository is WIP and may change without prior notice.
> No guarantee is made for correctness of the workflows.


## Usage

> [!NOTE]
> We will most likely provide a container image similar to the one for [appuio/guided-setup](https://github.com/appuio/guided-setup) in the future.

### Running manually

If you install [gandalf](https://github.com/appuio/gandalf) in addition to all workflow dependencies, you can run workflows without a container runtime:

```
gandalf run /path/to/workflows/cloudscale-install.workflow /path/to/workflows/cloudscale/*.yml /path/to/workflows/shared/*.yml
```
