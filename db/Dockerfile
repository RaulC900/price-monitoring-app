FROM postgres:latest

EXPOSE 5432

ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD admin
ENV POSTGRES_DB prices_db

COPY init_db.sh /docker-entrypoint-initdb.d/init_db.sh

#docker network create dbNetwork
#docker build -t prices_db .
#docker run -d --name prices_db --network dbNetwork -p 5432:5432 prices_db
