FROM linode/lamp
LABEL maintainer="timothy.l.jones@gmail.com"

# Finish setting up server
RUN apt-get update
RUN apt-get install -y php5-mysql php5-gd libgd2-xpm-dev
RUN apt-get install -y libfreetype6
RUN rm /var/www/example.com/public_html/index.html

# Add webDiplomacy harness
ADD scripts /scripts

# install the database
ADD webDiplomacy/install /db_install
RUN /scripts/init-db.sh

CMD /scripts/docker-entrypoint.sh
