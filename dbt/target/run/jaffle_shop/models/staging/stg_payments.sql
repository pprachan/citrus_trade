
  create or replace   view JAFFLE_SHOP.ANALYTICS.stg_payments
  
  
  
  
  as (
    SELECT
    id as payment_id
    ,order_id
    ,payment_method
    ,ROUND(amount/100, 2) as amount
FROM JAFFLE_SHOP.RAW.raw_payments
  );

