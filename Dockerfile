FROM ubuntu:25.10

# --- 2. 环境变量配置 ---
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH=$JAVA_HOME/bin:$PATH
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8
# --- 4. JDK 安装 ---
ENV JAVA_VERSION=jdk-17.0.17+10

RUN /bin/sh -c set -eux; ARCH="$(apk --print-arch)"; case "${ARCH}" in x86_64) ESUM='6c3047e8edd3878e8d2a1cee95c04606042c6a55954ad365d20b58f88cc9ecd5'; BINARY_URL='https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.17%2B10/OpenJDK17U-jre_x64_alpine-linux_hotspot_17.0.17_10.tar.gz'; ; ; *) echo "Unsupported arch: ${ARCH}"; exit 1; ; ; esac; wget -O /tmp/openjdk.tar.gz ${BINARY_URL}; wget -O /tmp/openjdk.tar.gz.sig ${BINARY_URL}.sig; export GNUPGHOME="$(mktemp -d)"; gpg --batch --keyserver keyserver.ubuntu.com --recv-keys 3B04D753C9050D9A5D343F39843C48A565F8F04B; gpg --batch --verify /tmp/openjdk.tar.gz.sig /tmp/openjdk.tar.gz; rm -rf "${GNUPGHOME}" /tmp/openjdk.tar.gz.sig; echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; mkdir -p "$JAVA_HOME"; tar --extract --file /tmp/openjdk.tar.gz --directory "$JAVA_HOME" --strip-components 1 --no-same-owner ; rm -f /tmp/openjdk.tar.gz; # buildkit
RUN /bin/sh -c set -eux; echo "Verifying install ..."; echo "java --version"; java --version; echo "Complete." # buildkit

COPY --chmod=755 entrypoint.sh /__cacert_entrypoint.sh
ENTRYPOINT ["/__cacert_entrypoint.sh"]
