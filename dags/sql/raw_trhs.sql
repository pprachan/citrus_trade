create or replace table trade_flow.raw.raw_trhs (
    value variant
);

---

copy into trade_flow.raw.raw_trhs
from @trade_flow.raw.s3_trhs_external_stage
pattern = '.*[.]parquet'
file_format = (format_name
