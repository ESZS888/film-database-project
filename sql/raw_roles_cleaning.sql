CREATE TABLE raw_roles (
    id TEXT,
    film_id TEXT,
    people_id TEXT,
    role TEXT
);

SELECT DISTINCT TRIM(r.film_id) AS invalid_film_id
FROM raw_roles r
LEFT JOIN films f
ON TRIM(r.film_id) = f.id::TEXT
WHERE r.film_id IS NOT NULL
  AND TRIM(r.film_id) <> ''
  AND f.id IS NULL
ORDER BY invalid_film_id;


DELETE FROM raw_roles r
WHERE r.film_id IS NOT NULL
  AND TRIM(r.film_id) <> ''
  AND NOT EXISTS (
      SELECT 1
      FROM films f
      WHERE f.id::TEXT = TRIM(r.film_id)
  );



/*
直接结论（中文总结）
- 这个 SQL 文件做了三件事：创建表、查找无效的 film_id、删除引用不存在 films.id 的行。

具体说明
- 创建表：
  - CREATE TABLE raw_roles (id TEXT, film_id TEXT, people_id TEXT, role TEXT);
  - raw_roles 有四个 TEXT 列，无主键、无外键约束。

- 诊断查询（预览要清理的 film_id）：
  - SELECT DISTINCT TRIM(r.film_id) AS invalid_film_id
    FROM raw_roles r
    LEFT JOIN films f
    ON TRIM(r.film_id) = f.id::TEXT
    WHERE r.film_id IS NOT NULL
      AND TRIM(r.film_id) <> ''
      AND f.id IS NULL
    ORDER BY invalid_film_id;
  - 作用：返回 raw_roles 中非空且去除首尾空白后无法在 films 表中匹配的 film_id（便于查看孤立/无效引用）。

- 删除操作（实际清理）：
  - DELETE FROM raw_roles r
    WHERE r.film_id IS NOT NULL
      AND TRIM(r.film_id) <> ''
      AND NOT EXISTS (
          SELECT 1
          FROM films f
          WHERE f.id::TEXT = TRIM(r.film_id)
      );
  - 作用：删除 raw_roles 中那些 film_id 非空、去空白后在 films 表中找不到对应 id 的记录。

注意点 / 行为细节
- 使用 TRIM(...) 去除首尾空白，避免因空格导致匹配失败。
- films.id 被显式 cast 为 TEXT（f.id::TEXT），说明 films.id 在源表中可能不是文本类型。
- 表结构没有约束，所以通过脚本来维持引用完整性（先查看，再删除）。
- 建议在执行 DELETE 前先备份或在事务中先运行 SELECT 检查要删除的行，避免误删。

我已查看并总结了该文件内容；如果你要，我可以：
- 列出将被删除的具体行供你确认，或
- 把删除操作改为带事务/回滚的脚本以便安全执行。
*/
