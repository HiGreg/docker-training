FROM centos:7.3v1
ENV DATA_DIR=/var/lib/mysql
RUN yum install  -y  mariadb mariadb-server && yum install -y gcc gcc-c++ git make automake cmake patch logrotate python-devel libpng-devel libjpeg-devel && \
    yum install -y --enablerepo=epel pwgen python-pip && \
    yum clean all 
ADD mysqld_charset.cnf /etc/my.cnf.d/
COPY scripts /scripts
RUN chmod a+x /scripts/*
EXPOSE 3306
VOLUME ["/var/lib/mysql"]
ENTRYPOINT ["/scripts/start.sh"]


