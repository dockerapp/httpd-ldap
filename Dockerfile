FROM php:apache
#RUN apk add --no-cache --virtual .build-deps apr-util-ldap && rm -rf /var/cache/apk/*
RUN apt-get update && apt-get install -y libldap2-dev

RUN     docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install ldap
RUN	a2enmod ldap && a2enmod authnz_ldap && a2enmod headers

RUN 	mkdir /etc/apache2/conf.d && \
	echo 'IncludeOptional conf.d/*.conf' >> /etc/apache2/apache2.conf 

EXPOSE 80

ENTRYPOINT ["docker-php-entrypoint"]
CMD ["apache2-foreground"]

