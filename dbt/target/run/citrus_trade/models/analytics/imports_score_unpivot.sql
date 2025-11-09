
  
    

create or replace transient table TRADE_FLOW.analytics.imports_score_unpivot
    
    
    
    as (with 
    scores as (
        select 
            declarant_iso,
            score_type,
            score
        from TRADE_FLOW.marts.imports_score
        unpivot (
            score for score_type in (
                revenue_score as "revenue",
                quantity_score as "quantity",
                price_score as "price",
                growth_score as "growth"
            )
        )
    ),
    metrics as (
        select 
            declarant_iso,
            metric_type,
            metric
        from TRADE_FLOW.marts.imports_score
        unpivot (
            metric for metric_type in (
                revenue_2020 as "revenue",
                quantity_2020 as "quantity",
                price_avg_2020 as "price"
            )
        )
    )
select 
    s.declarant_iso,
    s.score_type,
    s.score,
    m.metric,
    case 
        when s.score_type = 'revenue' then 'Euro'
        when s.score_type = 'quantity' then 'Kg'
        when s.score_type = 'price' then 'Euro per Kg'
    end as metric_unit
from scores as s
left join metrics as m
    on s.declarant_iso = m.declarant_iso
    and s.score_type = m.metric_type
    )
;


  