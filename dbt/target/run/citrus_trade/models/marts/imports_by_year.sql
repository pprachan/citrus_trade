
  
    

create or replace transient table TRADE_FLOW.marts.imports_by_year
    
    
    
    as (select
    declarant_iso,
    year,
    sum(value_in_euros) as revenue,
    sum(quantity_in_kg) as quantity,
    revenue/nullif(quantity,0) as price_avg
from TRADE_FLOW.marts.trade_by_hs
where flow = 1
group by 1,2
    )
;


  