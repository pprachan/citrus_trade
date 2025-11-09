with 
    previous_year AS (
        select 
            declarant_iso,
            year,
            lag(total_value,1) over(partition by declarant_iso order by year) previous_year_value,
            total_value,
            first_value(total_value) over(partition by declarant_iso order by year) as first_year_value,
            last_value(total_value) over(partition by declarant_iso order by year) as last_year_value
        from TRHS.analytics.imports_by_year
    ),
    growth_speed AS (
        select 
            declarant_iso,
            year,
            first_year_value,
            last_year_value,
            last_year_value/nullif(first_year_value,0) as growth_overall,
            previous_year_value,
            total_value,
            (total_value - previous_year_value)/total_value * 100 as growth_speed 
        from previous_year
    ),
    previous_year_growth_speed AS (
        select 
            declarant_iso,
            year,
            first_year_value,
            last_year_value,
            growth_overall,
            previous_year_value,
            total_value as current_value,
            growth_speed,
            lag(growth_speed,1) over(partition by declarant_iso order by year) previous_year_growth_speed,
        from growth_speed
        order by 1,2
    ),
    base AS (
        select 
            declarant_iso,
            year,
            first_year_value,
            last_year_value,
            growth_overall,
            previous_year_value,
            current_value,
            previous_year_growth_speed,
            growth_speed,
            growth_speed - previous_year_growth_speed as growth_acceleration,
            avg(growth_acceleration) over(partition by declarant_iso) as avg_acceleration
        from previous_year_growth_speed
    ),
    ok as (
        select 
            declarant_iso,
            year,
            first_year_value,
            last_year_value,
            growth_overall,
            (growth_overall - min(growth_overall) OVER())/(max(growth_overall) OVER() - min(growth_overall) OVER()) as growth_overall_norm,
            previous_year_value,
            current_value,
            -- previous_year_growth_speed,
            growth_speed,
            growth_acceleration,
            avg_acceleration,
            (avg_acceleration - min(avg_acceleration) OVER())/(max(avg_acceleration) OVER() - min(avg_acceleration) OVER()) as avg_acceleration_norm
        from base 
    )
    select 
        declarant_iso,
        year,
        current_value,
        growth_speed,
        growth_acceleration,
        growth_overall,
        growth_overall_norm,
        avg_acceleration,
        avg_acceleration_norm,
        growth_overall_norm * avg_acceleration_norm as growth_score
    from ok