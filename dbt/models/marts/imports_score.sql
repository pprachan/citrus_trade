select distinct
    sc.declarant_iso,
    sc.revenue as revenue_2020,
    sc.quantity as quantity_2020,
    sc.price_avg as price_avg_2020,
    gs.revenue_by_year,
    sc.revenue_score,
    sc.quantity_score,
    sc.price_score,
    gs.growth_score
from {{ ref('score_2020') }} as sc
inner join {{ ref('growth_score') }} as gs
    on gs.declarant_iso = sc.declarant_iso