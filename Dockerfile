FROM openjdk:8-jdk

MAINTAINER info@abroweb.ru

RUN apt-get install -y unzip

## for dev only
#ADD ./resources/wisemapping-v3.0.2.zip /root/wisemapping-v3.0.2.zip

ADD https://bitbucket.org/wisemapping/wisemapping-open-source/downloads/wisemapping-v3.0.2.zip /root/wisemapping-v3.0.2.zip



RUN cd /root && unzip wisemapping-v3.0.2.zip && rm wisemapping-v3.0.2.zip

ADD http://jdbc.postgresql.org/download/postgresql-9.1-903.jdbc4.jar /root/wisemapping-v3.0.2/lib/postgresql-9.1-903.jdbc4.jar
#ADD ./resources/postgresql-9.1-903.jdbc4.jar /root/wisemapping-v3.0.2/webapps/wisemapping/WEB-INF/lib/postgresql-9.1-903.jdbc4.jar

ADD ./resources/app.properties /root/wisemapping-v3.0.2/webapps/wisemapping/WEB-INF/app.properties

# Decouple our data from our container.
VOLUME ["/data"]

EXPOSE 8080

ADD /resources/scripts /scripts
RUN chmod +x /scripts/start.sh
RUN touch /firstrun

#ENTRYPOINT ["/scripts/start.sh"]

CMD ["java", "-jar", "/root/wisemapping-v3.0.2/webapps/WEB-INF/lib/wise-api-3.0.2.jar"]


