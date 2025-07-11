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

# Install other tools.
RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y pwgen inotify-tools

# Decouple our data from our container.
VOLUME ["/data"]

# Cofigure the database to use our data dir.
RUN sed -i -e"s/data_directory =.*$/data_directory = '\/data'/" /etc/postgresql/9.3/main/postgresql.conf
# Allow connections from anywhere.
RUN sed -i -e"s/^#listen_addresses =.*$/listen_addresses = '*'/" /etc/postgresql/9.3/main/postgresql.conf
RUN echo "host    all    all    0.0.0.0/0    md5" >> /etc/postgresql/9.3/main/pg_hba.conf



EXPOSE 8080

ADD /resources/scripts /scripts
RUN chmod +x /scripts/start.sh
RUN touch /firstrun

#ENTRYPOINT ["/scripts/start.sh"]

CMD /bin/bash

