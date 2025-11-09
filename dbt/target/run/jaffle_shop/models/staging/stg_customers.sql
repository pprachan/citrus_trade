
  create or replace   view JAFFLE_SHOP.ANALYTICS.stg_customers
  
  
  
  
  as (
    SELECT
    id as customer_id
    ,first_name
    ,last_name
FROM JAFFLE_SHOP.RAW.raw_customers
  );

