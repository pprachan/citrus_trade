select
    *
from {{ ref('stg_trhs') }}
where hs6 = '{{ var("hs6_code") }}'
