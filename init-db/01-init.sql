CREATE TABLE IF NOT EXISTS eventos (
    event_time TIMESTAMP,
    event_type TEXT,
    product_id BIGINT,
    category_id BIGINT,
    category_code TEXT,
    brand TEXT,
    price NUMERIC,
    user_id BIGINT,
    user_session UUID
);

\copy eventos FROM '/docker-entrypoint-initdb.d/2019-Oct.csv' DELIMITER ',' CSV HEADER;
