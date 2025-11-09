
  
    

create or replace transient table TRHS.analytics.trade_by_reporter
    
    
    
    as (select 
    declarant,
    declarant_iso,
    partner,
    partner_iso,
    flow,
    transport_mode,
    year(to_date(left(period,4),'YYYY')) as year,
    period,
    hs6,
    hs6_name,
    sum(value_in_euros) as total_value,
    sum(quantity_in_kg) as total_quantity
from TRHS.staging.stg_trade
group by 1,2,3,4,5,6,7,8,9,10
    )
;


  