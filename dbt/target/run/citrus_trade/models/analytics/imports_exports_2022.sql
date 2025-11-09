
  
    

create or replace transient table TRHS.analytics.imports_exports_2022
    
    
    
    as (select
    declarant_iso,
    flow,
    sum(value) over(partition by declarant_iso, flow) as total_value,
    sum(quantity) over(partition by declarant_iso, flow) as total_quantity,
    total_value/nullif(total_quantity,0) as value_per_quantity
from TRHS.analytics.trade_by_hs
group by 
    declarant_iso,
    flow,
    value,
    quantity
    )
;


  