# amq7-cert-manager-bundle

---
**NOTE**
You must use `docker` because there are issues with `podman` and the incorrect manifest version in the container metadata.
----

Build the bundle.

```
docker build -t quay.io/redhat-operators-stf/amq7-cert-manager-operator-bundle:v1.0.0 .
docker push quay.io/redhat-operators-stf/amq7-cert-manager-operator-bundle:v1.0.0
```

Create the index image with `opm`:

```
opm index add \
  --bundles quay.io/redhat-operators-stf/amq7-cert-manager-operator-bundle:v1.0.0 \
  --tag quay.io/redhat-operators-stf/stf-catalog:v4.6 \
  --build-tool docker
```

Update the index image in quay.io:

```
docker push quay.io/redhat-operators-stf/stf-catalog:v4.6
```

Install a custom `CatalogSource` in OpenShift:

```
oc apply -f - <<EOF
apiVersion: operators.coreos.com/v1alpha1
kind: CatalogSource
metadata:
  name: redhat-operators-stf
  namespace: openshift-marketplace
spec:
  displayName: Red Hat STF Operators
  image: quay.io/redhat-operators-stf/stf-catalog:v4.6
  publisher: Red Hat
  sourceType: grpc
  updateStrategy:
    registryPoll:
      interval: 30m
EOF
```
