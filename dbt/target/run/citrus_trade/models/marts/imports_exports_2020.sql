
  
    

create or replace transient table TRADE_FLOW.marts.imports_exports_2020
    
    
    
    as (select
    declarant_iso,
    flow,
    sum(value_in_euros) over(partition by declarant_iso, flow) as revenue,
    sum(quantity_in_kg) over(partition by declarant_iso, flow) as quantity,
    revenue/nullif(quantity,0) as price_avg
from TRADE_FLOW.marts.trade_by_hs
where year = 2020
group by 
    declarant_iso,
    flow,
    value_in_euros,
    quantity_in_kg
    )
;


  