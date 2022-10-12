FROM registry.fedoraproject.org/fedora-minimal:38

USER root

#RUN microdnf remove wkhtmltopdf -y
RUN microdnf install wget pandoc fontconfig freetype libX11 libXext libXrender libjpeg libpng openssl openssl1.1 xorg-x11-fonts-75dpi xorg-x11-fonts-Type1 -y
RUN wget -q https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox-0.12.6-1.centos8.x86_64.rpm
RUN rpm --install wkhtmltox-0.12.6-1.centos8.x86_64.rpm

RUN mkdir /app
RUN chown 1000:1000 /app

COPY --chown=100 themes /app/themes
COPY --chown=1000 pandoc.sh /app/pandoc.sh

USER 1000

ENV PATH="/app:$PATH" 

RUN mkdir /app/shared
RUN mkdir /app/shared/source
RUN mkdir /app/shared/dest
WORKDIR /app

ENTRYPOINT [ "pandoc.sh" ]