#!/bin/bash
checkdb = mysql - h localhost - u 'root' - p '26876209Vk*' - e 'show databases'
SELECT
  table_schema "DB Name",
  ROUND(
    SUM(data_length + index_length) / 1024 / 1024 / 1024,
    1
  ) "DB Size in GB"
FROM
  information_schema.tables
where
  table_schema = 'csm-client1'
GROUP BY
  table_schema;