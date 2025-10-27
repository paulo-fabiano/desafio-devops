FROM postgres:15.8
COPY init-db.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh
USER postgres
EXPOSE 5432