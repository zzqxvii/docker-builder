FROM bellsoft/liberica-runtime-container:jre-17-crac-cds-glibc
RUN apk add --no-cache sudo bash freetype freetype-dev fontconfig ttf-dejavu shadow procps coreutils psmisc
