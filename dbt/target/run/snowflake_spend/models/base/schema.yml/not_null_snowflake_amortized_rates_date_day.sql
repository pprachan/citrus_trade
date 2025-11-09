
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select date_day
from JAFFLE_SHOP.ANALYTICS.snowflake_amortized_rates
where date_day is null



  
  
      
    ) dbt_internal_test