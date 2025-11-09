with 
    revenue_by_hs as (
        select
            hs6,
            hs6_name,
            year,
            sum(value_in_euros) as revenue,
            sum(quantity_in_kg) as quantity,
            rank() over(partition by year order by revenue desc) as hs6_rank 
        from {{ ref('stg_trhs') }}
        where flow = 1
        and declarant_iso != 'ES'
        group by 1,2,3
    )
select 
    hs6,
    hs6_name,
    year,
    revenue,
    revenue/sum(revenue) over (partition by year) as revenue_share,
    quantity,
    hs6_rank
from revenue_by_hs