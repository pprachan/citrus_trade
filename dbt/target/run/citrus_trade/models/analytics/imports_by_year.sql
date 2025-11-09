
  
    

create or replace transient table TRHS.analytics.imports_by_year
    
    
    
    as (select
    declarant_iso,
    year,
    sum(value) as total_value,
    sum(quantity) as total_quantity,
    total_value/nullif(total_quantity,0) as value_per_quantity
from TRHS.analytics.trade_by_hs
where flow = 1
group by 1,2
    )
;


  