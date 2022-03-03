FROM alpine:3.15

RUN apk update

RUN apk add bash build-base R R-dev R-doc libxml2-dev curl-dev \
            libssh-dev openssl-dev linux-headers

RUN Rscript -e "install.packages('lintr', repos = 'https://cloud.r-project.org/')"

