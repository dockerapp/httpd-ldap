FROM httpd:alpine
RUN apk add --no-cache --virtual .build-deps apr-util-ldap && rm -rf /var/cache/apk/*
RUN 	mkdir /usr/local/apache2/conf.d && \
	echo 'Include conf.d/*.conf' >> /usr/local/apache2/conf/httpd.conf && \
	sed -i 's/^#LoadModule authnz_ldap_module/LoadModule authnz_ldap_module/' /usr/local/apache2/conf/httpd.conf && \
	sed -i 's/^#LoadModule ldap_module/LoadModule ldap_module/' /usr/local/apache2/conf/httpd.conf

EXPOSE 80
CMD ["httpd-foreground"]

