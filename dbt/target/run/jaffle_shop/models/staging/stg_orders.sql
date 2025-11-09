
  create or replace   view JAFFLE_SHOP.ANALYTICS.stg_orders
  
  
  
  
  as (
    SELECT
        id as order_id
        ,user_id as customer_id
        ,order_date
        ,status
    FROM JAFFLE_SHOP.RAW.raw_orders
  );

