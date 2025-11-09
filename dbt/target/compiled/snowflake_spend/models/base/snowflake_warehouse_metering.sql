WITH base AS (

	SELECT *
	FROM snowflake.account_usage.warehouse_metering_history

)

SELECT
  warehouse_id,
  warehouse_name,
  start_time,
  end_time,
  credits_used
FROM base