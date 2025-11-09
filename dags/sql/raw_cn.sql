create or replace table trade_flow.raw.raw_cn  (
  hs6 string,
  hs6_name string,
  hs4 string,
  hs4_name string,
  hs2 string,
  hs2_name string
);

---

copy into trade_flow.raw.raw_cn 
from @trade_flow.raw.s3_metadata_external_stage/cn_modified.csv
file_format = (format_name = 'trade_flow.raw.csv_comma_file_format');