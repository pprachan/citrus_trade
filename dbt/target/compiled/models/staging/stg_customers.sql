SELECT
    id
    ,split_part(name,' ',1) as first_name
    ,split_part(name,' ',2) as last_name
FROM JAFFLE_SHOP.RAW.raw_customers