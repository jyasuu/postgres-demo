# postgres-demo



docker compose down
docker compose up -d
sleep 5
docker compose cp postgresql.conf postgres:/var/lib/postgresql/data/postgresql.conf
docker compose restart postgres
sleep 5
docker compose exec postgres psql -U postgres
  

  pg_recvlogical \
  -d postgres \
  --slot my_slot \
  --start \
  -f - \
  -o proto_version=4 \
  -o publication_names=my_pub \
  -o binary=false \
  -o messages=true \
  -U postgres \
  -P postgres

curl -H "Accept:application/json" localhost:8083/ | jq


curl -H "Accept:application/json" localhost:8083/connectors | jq

curl -i -X POST -H "Accept:application/json" \
  -H "Content-Type:application/json" \
  localhost:8083/connectors/ \
  -d '{
    "name": "public-connector",
    "config": {
      "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
      "database.hostname": "postgres",
      "database.port": "5432",
      "database.user": "postgres",
      "database.password": "postgres",
      "database.dbname": "postgres",
      "database.server.name": "dbserver1",
      "table.include.list": "public.users",
      "topic.prefix": "dbserver",   
      "schema.history.internal.kafka.bootstrap.servers": "kafka:9092",  
      "plugin.name": "pgoutput"
    }
  }' 

curl -H "Accept:application/json" localhost:8083/connectors/public-connector | jq