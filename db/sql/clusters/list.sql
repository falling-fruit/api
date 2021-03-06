SELECT ST_X(center) as lng, ST_Y(center) as lat, count
FROM (
  SELECT
    SUM(count) as count,
    ST_Transform(ST_SetSRID(ST_POINT(
      SUM(count * x) / SUM(count),
      SUM(count * y) / SUM(count)
    ), 3857), 4326) as center
  FROM clusters
  WHERE ${where:raw}
  GROUP BY geohash
) subq
