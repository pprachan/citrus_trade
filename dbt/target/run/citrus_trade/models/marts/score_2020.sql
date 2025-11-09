
  
    

create or replace transient table TRADE_FLOW.marts.score_2020
    
    
    
    as (select distinct 
    declarant_iso,
    revenue,
    quantity,
    price_avg,
    (revenue - min(revenue) over())/((max(revenue) over())-(min(revenue) over())) as revenue_score,
    (quantity - min(quantity) over())/((max(quantity) over())-(min(quantity) over())) as quantity_score,
    (price_avg - min(price_avg) over())/((max(price_avg) over())-(min(price_avg) over())) as price_score
from TRADE_FLOW.marts.imports_exports_2020
where flow = 1
    )
;


  