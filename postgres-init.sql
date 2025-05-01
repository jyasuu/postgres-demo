CREATE EXTENSION IF NOT EXISTS pageinspect;
CREATE EXTENSION IF NOT EXISTS pgstattuple;

-- Create a test table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE
);

-- Create a publication for the table
-- CREATE PUBLICATION my_pub FOR TABLE users;

-- SELECT pg_create_logical_replication_slot(
--     'my_slot', 
--     'pgoutput'
-- );

-- START_REPLICATION SLOT my_slot LOGICAL 0/0 (
--   proto_version '1',
--   publication_names 'my_pub'
-- );

-- SELECT * FROM pg_replication_slots;

-- INSERT INTO users (name, email) VALUES ('Alice', 'alice@example.com');
-- UPDATE users SET email = 'alice_new@example.com' WHERE id = 1;
-- DELETE FROM users WHERE id = 1;


-- SELECT data FROM pg_logical_slot_get_binary_changes('my_slot', NULL, NULL);

-- SELECT * FROM pg_logical_slot_get_changes('my_slot', NULL, NULL, 'include-xids', '0');

-- SELECT data FROM pg_logical_slot_get_changes('my_slot', NULL, NULL, 'pretty-print', '1');

-- SELECT * FROM pg_logical_slot_get_binary_changes('my_slot', NULL, NULL, 'proto_version', '4', 'publication_names', 'my_pub');