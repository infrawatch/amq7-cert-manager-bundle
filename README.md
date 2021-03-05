# amq7-cert-manager-bundle

---
**NOTE**

You must use `docker` because there are issues with `podman` and the incorrect manifest version in the container metadata.

----

## Building Bundle and Index Image

Skip to **Enabling redhat-operators-stf CatalogSource** below if you don't need to update/build the bundle and index image.

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

## Enabling redhat-operators-stf CatalogSource

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

## Subscribe to amq7-cert-manager-operator

Subscribe to the AMQ7 CertManager Operator to have it installed cluster-wide:

```
oc apply -f - <<EOF
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: amq7-cert-manager
  namespace: openshift-operators
spec:
  channel: alpha
  installPlanApproval: Automatic
  name: amq7-cert-manager-operator
  source: redhat-operators-stf
  sourceNamespace: openshift-marketplace
EOF
```
