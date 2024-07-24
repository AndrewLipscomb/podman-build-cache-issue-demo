FROM ubuntu:24.04

RUN  \
    --mount=target=/source,type=bind,source=src,ro \
    cat /source/my_content > /my_content