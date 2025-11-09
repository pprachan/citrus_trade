
  
    

create or replace transient table TRADE_FLOW.staging.stg_trhs
    
    
    
    as (select
  value:DECLARANT::int as declarant,
  value:DECLARANT_ISO::string as declarant_iso,
  value:PARTNER::string as partner,
  value:PARTNER_ISO::string as partner_iso,
  value:FLOW::int as flow,
  value:TRANSPORT_MODE::int as transport_mode,
  value:PERIOD::int as period,
  year(to_date(left(period,4),'YYYY')) as year,
  value:HS4::string as hs4,
  value:HS4_NAME::string as hs4_name,
  value:HS6::string as hs6,
  value:HS6_NAME::string as hs6_name,
  value:VALUE_IN_EUROS::float as value_in_euros,
  value:QUANTITY_IN_KG::float as quantity_in_kg
from trade_flow.raw.raw_trhs
    )
;


  