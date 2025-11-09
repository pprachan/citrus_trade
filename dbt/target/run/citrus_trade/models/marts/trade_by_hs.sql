
  
    

create or replace transient table TRADE_FLOW.marts.trade_by_hs
    
    
    
    as (select
    *
from TRADE_FLOW.staging.stg_trhs
where hs6 = '080510'
    )
;


  