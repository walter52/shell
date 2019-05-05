FROM alpine:3.9
RUN echo http://mirrors.ustc.edu.cn/alpine/v3.8/main > /etc/apk/repositories \
&& echo http://mirrors.ustc.edu.cn/alpine/v3.8/community >> /etc/apk/repositories \
&& apk update \
&& apk upgrade \
&& apk add mysql-client
ENTRYPOINT ["mysql"]