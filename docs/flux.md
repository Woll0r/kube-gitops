# Flux

## Install the CLI

```sh
brew install fluxcd/tap/flux
```

## Install components

*For more details, see the [Flux documentation]*

Set Github access information with an access token from Github.

```sh
export GITHUB_TOKEN=abc123def456ghi789
export GITHUB_USER=Woll0r
```

Run the checks to make sure the cluster is ready.

```sh
flux check --pre
```

Install Flux.

```sh

flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=kube-gitops \
  --interval=5m \
  --branch=main \
  --path=./cluster \
  --personal
  --network-policy=false
```

!!! note
    Network policy and K3S don't seem to play nicely, hence it is getting
    disabled.

## Useful commands

Force flux to sync your repository:

```sh
flux reconcile source git flux-system
```

Force flux to sync a helm release:

```sh
flux reconcile helmrelease sonarr -n default
```

Force flux to sync a helm repository:

```sh
flux reconcile source helm ingress-nginx-charts -n flux-system
```

[Flux documentation]: https://toolkit.fluxcd.io/guides/installation/
