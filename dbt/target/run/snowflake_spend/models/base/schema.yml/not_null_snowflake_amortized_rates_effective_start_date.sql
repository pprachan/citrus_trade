
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select effective_start_date
from JAFFLE_SHOP.ANALYTICS.snowflake_amortized_rates
where effective_start_date is null



  
  
      
    ) dbt_internal_test