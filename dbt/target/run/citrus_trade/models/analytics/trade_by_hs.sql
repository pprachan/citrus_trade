
  
    

create or replace transient table TRHS.analytics.trade_by_hs
    
    
    
    as (select
    *
from TRHS.analytics.trade_by_declarant
where hs6 = '080510'
    )
;


  