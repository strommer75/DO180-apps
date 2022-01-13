FROM ubi8/ubi:8.3
MAINTAINER francesco

#RUN yum -y update && yum clean all
RUN yum -y install unzip && yum clean all
RUN groupadd -r jboss -g 1000 && useradd -u 1000 -r -g jboss -m -d /opt/jboss -s /sbin/nologin -c "JBoss user" jboss

WORKDIR /opt/jboss

USER root

#RUN yum -y install java-1.7.0-openjdk-devel && yum clean all
RUN yum -y install java-1.8.0-openjdk-devel && yum clean all

USER jboss

ENV JAVA_HOME /usr/lib/jvm/java

COPY ./wildfly-26.0.0.Final.zip .
RUN unzip wildfly-26.0.0.Final.zip

ENV JBOSS_HOME /opt/jboss/wildfly-preview-26.0.0.Final

EXPOSE 8080 9990
CMD ["/opt/jboss/wildfly-preview-26.0.0.Final/bin/standalone.sh", "-c", "standalone-full.xml", "-b", "0.0.0.0"]
