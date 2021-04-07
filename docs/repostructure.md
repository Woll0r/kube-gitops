# Repository structure

## Overview

The repo is structured in a way to make it easier as a human to follow the
structure and for Flux to read the structure, along with using specific files
and folders in certain locations makes everything work.

## The `cluster` folder

The `cluster` folder contains all of the Kubernetes manifests used by Flux to
populate the cluster. Inside the folder, there is a division in different
folders, each with their own purpose

Alongside these, there is also the `kustomization.yaml` file to apply everything
and the other named yaml files, one per folder.

### `flux-system`

The `flux-system` folder is the one holding all of the files related to and
needed by Flux to do the basic parts of it's job.

### `namespaces` and `crds`

These folders contain `CustomResourceDefinition` and `Namespace` objects. It is
the first set of manifests to be applied after Flux's own manifests and is
required to be one of the first things to apply because later resources make use
of the custom resources defined in here or are placed in namespaces that might
not exist otherwise.

### `infra`

The `infra` folder contains all underlying infrastructure items, such as
storage, monitoring, certificates, ingress, DNS and oauth2 provider. These are
placed in folders per namespace, similar to the `apps` folder later on.

The items in this folder depend on both `namespaces` and `crds` to be applied.

### `apps`

This folder contains all of the user facing applications running in the cluster.
They have a dependency on (one or more parts of) `infra` and by extension `crds`
and `namespaces`.

## The `docs` folder

Contains the MarkDown files for the documentation you are reading right now.

## The rest

All of the other files are configuration files, scripts to generate secrets,
and helper files to make life easier when working on the contents of the repo.
