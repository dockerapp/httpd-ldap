FROM php:apache
#RUN apk add --no-cache --virtual .build-deps apr-util-ldap && rm -rf /var/cache/apk/*
RUN apt-get update && apt-get install -y libldap2-dev

RUN     docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install ldap
RUN	cp /etc/apache2/mods-available/*ldap* /etc/apache2/mods-enabled

RUN 	mkdir /etc/apache2/conf.d && \
	echo 'IncludeOptional conf.d/*.conf' >> /etc/apache2/apache2.conf 
#&& \
#	sed -i 's/^#LoadModule authnz_ldap_module/LoadModule authnz_ldap_module/' /usr/local/apache2/conf/httpd.conf && \
#	sed -i 's/^#LoadModule ldap_module/LoadModule ldap_module/' /usr/local/apache2/conf/httpd.conf

EXPOSE 80

ENTRYPOINT ["docker-php-entrypoint"]
CMD ["apache2-foreground"]

