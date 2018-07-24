FROM alpine:3.8
LABEL mantainer "hacklab/ <contato@hacklab.com.br>"

RUN apk --update add openssh nmap nmap-scripts curl tcpdump bind-tools jq nmap-ncat wget
