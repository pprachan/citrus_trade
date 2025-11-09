
  
    

create or replace transient table JAFFLE_SHOP.ANALYTICS.daily_summary_orders
    
    
    
    as (select
    md5(cast(coalesce(cast(customer_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(order_date as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as primary_key
    ,customer_id
    ,order_date
    ,count(*) as c
from JAFFLE_SHOP.ANALYTICS.stg_orders
group by 1,2,3
    )
;


  