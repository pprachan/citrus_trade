
  create or replace   view JAFFLE_SHOP.ANALYTICS.snowflake_amortized_rates
  
  
  
  
  as (
    WITH contract_rates AS (

    SELECT *
    FROM JAFFLE_SHOP.ANALYTICS.snowflake_contract_rates

), contract_rate_rework AS (

    SELECT  
      effective_date    AS effective_start_date,
      DATEADD(day, -1, LEAD(effective_date, 1, '2059-01-01') OVER (
          ORDER BY effective_date ASC
        ))              AS effective_end_date,
      rate
    FROM contract_rates

), date_spine AS (

  





with rawdata as (

    

    

    with p as (
        select 0 as generated_number union all select 1
    ), unioned as (

    select

    
    p0.generated_number * power(2, 0)
     + 
    
    p1.generated_number * power(2, 1)
     + 
    
    p2.generated_number * power(2, 2)
     + 
    
    p3.generated_number * power(2, 3)
     + 
    
    p4.generated_number * power(2, 4)
     + 
    
    p5.generated_number * power(2, 5)
     + 
    
    p6.generated_number * power(2, 6)
     + 
    
    p7.generated_number * power(2, 7)
     + 
    
    p8.generated_number * power(2, 8)
     + 
    
    p9.generated_number * power(2, 9)
     + 
    
    p10.generated_number * power(2, 10)
     + 
    
    p11.generated_number * power(2, 11)
     + 
    
    p12.generated_number * power(2, 12)
     + 
    
    p13.generated_number * power(2, 13)
     + 
    
    p14.generated_number * power(2, 14)
    
    
    + 1
    as generated_number

    from

    
    p as p0
     cross join 
    
    p as p1
     cross join 
    
    p as p2
     cross join 
    
    p as p3
     cross join 
    
    p as p4
     cross join 
    
    p as p5
     cross join 
    
    p as p6
     cross join 
    
    p as p7
     cross join 
    
    p as p8
     cross join 
    
    p as p9
     cross join 
    
    p as p10
     cross join 
    
    p as p11
     cross join 
    
    p as p12
     cross join 
    
    p as p13
     cross join 
    
    p as p14
    
    

    )

    select *
    from unioned
    where generated_number <= 20444
    order by generated_number



),

all_periods as (

    select (
        

    dateadd(
        day,
        row_number() over (order by generated_number) - 1,
        to_date('11/01/2009', 'mm/dd/yyyy')
        )


    ) as date_day
    from rawdata

),

filtered as (

    select *
    from all_periods
    where date_day <= dateadd(year, 40, current_date)

)

select * from filtered



), date_details AS (

    SELECT  
      date_day,
      DATE_PART(month, date_day)    AS month_actual,
      DATE_PART(year, date_day)     AS year_actual,
      FIRST_VALUE(date_day) OVER (
          PARTITION BY year_actual, month_actual ORDER BY date_day
        )                           AS first_day_of_month
    FROM date_spine

), rate_amortized AS (

    SELECT 
      contract_rate_rework.*,
      date_details.date_day
    FROM contract_rate_rework
    LEFT JOIN date_details 
      ON date_details.date_day >= contract_rate_rework.effective_start_date
        AND date_details.date_day <= contract_rate_rework.effective_end_date

)

SELECT *
FROM rate_amortized
  );

