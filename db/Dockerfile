FROM postgres
ENV POSTGRES_PASSWORD=docker
ENV POSTGRES_DB="planets"
COPY "planets".sql /docker-entrypoint-initdb.d/
