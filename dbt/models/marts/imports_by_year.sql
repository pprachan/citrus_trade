select
    declarant_iso,
    year,
    sum(value_in_euros) as revenue,
    sum(quantity_in_kg) as quantity,
    revenue/nullif(quantity,0) as price_avg
from {{ ref('trade_by_hs') }}
where flow = 1
group by 1,2