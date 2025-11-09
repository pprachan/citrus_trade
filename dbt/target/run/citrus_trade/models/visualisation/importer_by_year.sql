
  create or replace   view TRHS.visualisation.importer_by_year
  
  
  
  
  as (
    select
    declarant_iso,
    year,
    sum(total_value) as total_value,
    sum(total_quantity) as total_quantity,
    sum(total_value)/nullif(sum(total_quantity),0) as value_per_quantity
from TRHS.analytics.trade_by_reporter
where flow = 1
group by 1,2
  );

