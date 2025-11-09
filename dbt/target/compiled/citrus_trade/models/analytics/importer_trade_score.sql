select 
    declarant_iso,
    score_type,
    score
from (
    select distinct
        sc.declarant_iso,
        sc.value_score,
        sc.quantity_score,
        sc.price_score,
        gs.growth_score
    from TRADE_FLOW.marts.score_2020 as sc
    inner join TRADE_FLOW.marts.growth_score as gs
        on gs.declarant_iso = sc.declarant_iso
)
unpivot (
    score for score_type in (
        value_score,
        quantity_score,
        price_score,
        growth_score
    )
)