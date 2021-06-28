# Copyright 2021 Red Hat
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# ------------------------------------------------------------------------

FROM scratch

LABEL operators.operatorframework.io.bundle.mediatype.v1=registry+v1
LABEL operators.operatorframework.io.bundle.manifests.v1=manifests/
LABEL operators.operatorframework.io.bundle.metadata.v1=metadata/
LABEL operators.operatorframework.io.bundle.package.v1=amq7-cert-manager-operator
LABEL operators.operatorframework.io.bundle.channels.v1=alpha
LABEL operators.operatorframework.io.bundle.channel.default.v1=alpha
LABEL com.redhat.openshift.versions="v4.5-v4.7"
LABEL com.redhat.delivery.backport=true

LABEL \
      com.redhat.component="amq7-cert-manager-operator-bundle-container"  \
      description="Red Hat Integration AMQ CertManager Operator"  \
      io.k8s.description="An operator for AMQ CertManager."  \
      io.k8s.display-name="Red Hat Integration AMQ CertManager Operator"  \
      io.openshift.tags="messaging,amq"  \
      maintainer="Leif Madsen <leif@redhat.com>"  \
      name="amq7/amq-cert-manager-operator-bundle"  \
      summary="Red Hat Integration AMQ CertManager Operator"  \
      com.redhat.delivery.operator.bundle=true  \
      version="1.0"

COPY manifests/*.yaml /manifests/
COPY metadata/annotations.yaml /metadata/annotations.yaml
