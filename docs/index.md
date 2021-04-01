# Kube-GitOps

Welcome to the documentation of my Kubernetes cluster at home, running using
GitOps.

## The story so far

Back in 2018, while running Docker, I first came across this magical thing
called Kubernetes. The first attempts at using it failed horribly, until in
early 2020 I came across the repositories of people running it at home, with
GitOps principles to keep things up to date and using K3S to make the
installation and updating of Kubernetes itself a breeze.

Fast forward about a year, Flux2 is now a thing and using Renovate to update
everything, it was time to throw out the old cluster that barely has received
any planning or thought and start anew. The new cluster will eventually replace
the old, everything will stay up to date thanks to Renovate, there's actual
documentation on how everything works (:wave: you're reading that right now)
and it's all nice and clean.
