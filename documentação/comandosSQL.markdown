# Comandos SQL para Gerenciamento de Índices no PostgreSQL

Este documento apresenta os comandos SQL utilizados para verificar, criar, desabilitar e remover índices na tabela `eventos` do PostgreSQL, conforme descrito no trabalho de Banco de Dados. Os índices foram aplicados nas colunas `user_id` e `product_id`, incluindo os tipos B-tree, Hash e BRIN, com comandos para consultas de desempenho e gerenciamento de índices.

## Verificar Índices Criados

Para verificar se os índices foram criados na tabela `eventos`:

```sql
SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'eventos';
```

## Desabilitar Índices

Os seguintes comandos desabilitam diferentes tipos de varredura no PostgreSQL para forçar o uso de índices ou avaliar o comportamento sem varredura sequencial:

1. **Desabilitar varredura sequencial (Seq Scan)**:
   ```sql
   SET enable_seqscan = off;
   ```

2. **Desabilitar varredura de índice B-tree (Index Scan)**:
   ```sql
   SET enable_indexscan = off;
   ```

3. **Desabilitar varredura de índice Bitmap (Bitmap Index Scan)**:
   ```sql
   SET enable_bitmapscan = off;
   ```

## Consultas nos Índices

As consultas a seguir foram usadas para avaliar o desempenho com os índices nas colunas `user_id` e `product_id`, utilizando o comando `EXPLAIN ANALYZE`:

1. **Consulta na coluna `user_id`**:
   ```sql
   EXPLAIN ANALYZE
   SELECT * FROM eventos WHERE user_id = 542737410;
   ```

2. **Consulta na coluna `product_id`**:
   ```sql
   EXPLAIN ANALYZE
   SELECT * FROM eventos WHERE product_id = 1500021;
   ```

## Adicionando Índices na Coluna `user_id`

Os seguintes comandos criam índices na coluna `user_id`:

1. **Índice B-tree**:
   ```sql
   CREATE INDEX idx_userid_btree ON eventos(user_id);
   ```

2. **Índice Hash**:
   ```sql
   CREATE INDEX idx_userid_hash ON eventos USING HASH (user_id);
   ```

3. **Índice BRIN**:
   ```sql
   CREATE INDEX idx_userid_brin ON eventos USING BRIN (user_id);
   ```

## Removendo Índices da Coluna `user_id`

Os seguintes comandos removem os índices da coluna `user_id`:

1. **Remover índice B-tree**:
   ```sql
   DROP INDEX IF EXISTS idx_userid_btree;
   ```

2. **Remover índice Hash**:
   ```sql
   DROP INDEX IF EXISTS idx_userid_hash;
   ```

3. **Remover índice BRIN**:
   ```sql
   DROP INDEX IF EXISTS idx_userid_brin;
   ```

## Adicionando Índices na Coluna `product_id`

Os seguintes comandos criam índices na coluna `product_id`:

1. **Índice B-tree**:
   ```sql
   CREATE INDEX idx_productid_btree ON eventos(product_id);
   ```

2. **Índice Hash**:
   ```sql
   CREATE INDEX idx_productid_hash ON eventos USING HASH (product_id);
   ```

3. **Índice BRIN**:
   ```sql
   CREATE INDEX idx_productid_brin ON eventos USING BRIN (product_id);
   ```

## Removendo Índices da Coluna `product_id`

Os seguintes comandos removem os índices da coluna `product_id`:

1. **Remover índice B-tree**:
   ```sql
   DROP INDEX IF EXISTS idx_productid_btree;
   ```

2. **Remover índice Hash**:
   ```sql
   DROP INDEX IF EXISTS idx_productid_hash;
   ```

3. **Remover índice BRIN**:
   ```sql
   DROP INDEX IF EXISTS idx_productid_brin;
   ```