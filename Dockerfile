##Dockerfile
FROM centos:latest
MAINTAINER abhijit.kale@hotmail.com
RUN sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo
RUN sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo
RUN sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum install -y httpd \
zip \
unzip
#ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /tmp/photogenic.zip && cp -f /tmp/photogenic.zip /var/www/html/photogenic.zip
RUN curl -o /var/www/html/photogenic.zip https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip
WORKDIR /var/www/html
RUN unzip photogenic.zip
RUN cp -rvf photogenic/* .
RUN rm -rf photogenic photogenic.zip
CMD ["/user/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80