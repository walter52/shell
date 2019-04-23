FROM alpine:3.9
RUN echo http://mirrors.ustc.edu.cn/alpine/v3.8/main > /etc/apk/repositories
RUN echo http://mirrors.ustc.edu.cn/alpine/v3.8/community >> /etc/apk/repositories
RUN apk update && apk upgrade
RUN apk add mysql-client
ENTRYPOINT ["mysql"]