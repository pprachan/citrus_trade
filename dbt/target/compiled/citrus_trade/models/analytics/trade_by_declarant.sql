select 
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
    sum(value_in_euros) as value,
    sum(quantity_in_kg) as quantity
from TRHS.staging.stg_trade
group by 1,2,3,4,5,6,7,8,9,10