
  
    

create or replace transient table TRADE_FLOW.marts.growth_score
    
    
    
    as (with 
    previous_year AS (
        select 
            declarant_iso,
            year,
            lag(revenue,1) over(partition by declarant_iso order by year) revenue_previous_year,
            revenue,
            first_value(revenue) over(partition by declarant_iso order by year) as revenue_first_year,
            last_value(revenue) over(partition by declarant_iso order by year) as revenue_last_year
        from TRADE_FLOW.marts.imports_by_year
    ),
    growth_speed AS (
        select 
            declarant_iso,
            year,
            revenue_first_year,
            revenue_last_year,
            revenue_last_year/nullif(revenue_first_year,0) as growth_overall,
            revenue_previous_year,
            revenue,
            (revenue - revenue_previous_year)/revenue * 100 as growth_speed 
        from previous_year
    ),
    previous_year_growth_speed AS (
        select 
            declarant_iso,
            year,
            revenue_first_year,
            revenue_last_year,
            growth_overall,
            revenue_previous_year,
            revenue,
            growth_speed,
            lag(growth_speed,1) over(partition by declarant_iso order by year) growth_speed_previous_year,
        from growth_speed
    ),
    avg_acc AS (
        select 
            declarant_iso,
            year,
            revenue_first_year,
            revenue_last_year,
            growth_overall,
            revenue_previous_year,
            revenue,
            growth_speed_previous_year,
            growth_speed,
            growth_speed - growth_speed_previous_year as growth_acceleration,
            avg(growth_acceleration) over(partition by declarant_iso) as avg_acceleration
        from previous_year_growth_speed
    ),
    normalized as (
        select 
            declarant_iso,
            year,
            revenue_first_year,
            revenue_last_year,
            growth_overall,
            (growth_overall - min(growth_overall) OVER())/(max(growth_overall) OVER() - min(growth_overall) OVER()) as growth_overall_norm,
            revenue_previous_year,
            revenue,
            growth_speed_previous_year,
            growth_speed,
            growth_acceleration,
            avg_acceleration,
            (avg_acceleration - min(avg_acceleration) OVER())/(max(avg_acceleration) OVER() - min(avg_acceleration) OVER()) as avg_acceleration_norm
        from avg_acc 
    )
    select 
        declarant_iso,
        growth_overall_norm * avg_acceleration_norm as growth_score,
        array_agg(object_construct('year',year,'revenue',cast(revenue as string))) within group (order by year) as revenue_by_year
    from normalized 
    group by 1,2
    )
;


  