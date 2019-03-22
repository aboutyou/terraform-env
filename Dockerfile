FROM quay.io/aboutyou/envrun:0.5.2

FROM golang:alpine

ENV TERRAFORM_VERSION 0.11.1

COPY --from=0 /go/bin/envrun /usr/bin/envrun
RUN apk update && apk add make zip

WORKDIR /terraform

RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip && mv terraform /usr/bin/terraform

RUN addgroup -S -g 998 jenkins && adduser -S -u 999 -G jenkins jenkins

USER jenkins

CMD make ci
