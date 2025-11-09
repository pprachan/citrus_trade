
  
    

create or replace transient table TRADE_FLOW.marts.score_2022
    
    
    
    as (select distinct 
    declarant_iso,
    total_value,
    total_quantity,
    value_per_quantity,
    (total_value - min(total_value) over())/((max(total_value) over())-(min(total_value) over())) as score_value,
    (total_quantity - min(total_quantity) over())/((max(total_quantity) over())-(min(total_quantity) over())) as score_quantity,
    (value_per_quantity - min(value_per_quantity) over())/((max(value_per_quantity) over())-(min(value_per_quantity) over())) as score_price
from TRADE_FLOW.marts.imports_exports_2022
where flow = 1
    )
;


  