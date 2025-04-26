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
  -U postgres \
  -P postgres