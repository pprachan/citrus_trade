create or replace table trade_flow.raw.raw_iso_codes(
  iso2 string,
  iso3 string,
  country string,
  continent string
);

---

copy into trade_flow.raw.raw_iso_codes
from @trade_flow.raw.s3_metadata_external_stage/iso_codes.csv
file_format = (format_name = 'trade_flow.raw.csv_semicolon_format');
