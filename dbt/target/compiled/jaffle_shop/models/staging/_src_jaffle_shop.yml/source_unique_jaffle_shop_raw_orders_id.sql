
    
    

select
    id as unique_field,
    count(*) as n_records

from JAFFLE_SHOP.RAW.raw_orders
where id is not null
group by id
having count(*) > 1


