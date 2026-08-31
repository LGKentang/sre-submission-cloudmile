# check sonatype release
# https://github.com/sonatype-nexus-community/nexus-blobstore-google-cloud/releases
ARG NEXUS_VERSION=3.61.0
ARG NEXUS_IMAGE_TAG=3.61.0
ARG GCS_PLUGIN_VERSION=0.61.0

FROM sonatype/nexus3:${NEXUS_IMAGE_TAG}
ARG GCS_PLUGIN_VERSION
ARG NEXUS_VERSION
LABEL maintainer="Darren Maverick" \
      description="Sonatype Nexus3 with GCS blobstore plugin" \
      nexus.version="${NEXUS_VERSION}" \
      gcs.plugin.version="${GCS_PLUGIN_VERSION}"
      
# (required) to run the installation
USER root 

ENV NEXUS_HOME=/opt/sonatype/nexus

RUN set -eux; \
    curl -fsSL -o /tmp/nexus-blobstore-google-cloud.kar \
      "https://search.maven.org/remotecontent?filepath=org/sonatype/nexus/plugins/nexus-blobstore-google-cloud/${GCS_PLUGIN_VERSION}/nexus-blobstore-google-cloud-${GCS_PLUGIN_VERSION}-bundle.kar" \
    || curl -fsSL -o /tmp/nexus-blobstore-google-cloud.kar \
      "https://repo1.maven.org/maven2/org/sonatype/nexus/plugins/nexus-blobstore-google-cloud/${GCS_PLUGIN_VERSION}/nexus-blobstore-google-cloud-${GCS_PLUGIN_VERSION}-bundle.kar"; \
    mkdir -p "${NEXUS_HOME}/deploy"; \
    cp /tmp/nexus-blobstore-google-cloud.kar "${NEXUS_HOME}/deploy/"; \
    chown -R nexus:nexus "${NEXUS_HOME}/deploy"; \
    rm -f /tmp/nexus-blobstore-google-cloud.kar

USER nexus

ENV INSTALL4J_ADD_VM_PARAMS="-Xms512m -Xmx768m -XX:MaxDirectMemorySize=512m -XX:MaxMetaspaceSize=256m -Djava.util.prefs.userRoot=${NEXUS_HOME}"

EXPOSE 8081

# entrypoint/cmd is managed from the sonatype/nexus3 base image
