{% macro grant_select(schema=target.schema, role=target.role) %}

  {% set sql %}
  grant usage on schema {{ schema }} to role {{ role }};

  -- Existing tables and views
  grant select on all tables in schema {{ schema }} to role {{ role }};
  grant select on all views in schema {{ schema }} to role {{ role }};

  -- Future tables and views
  grant select on future tables in schema {{ schema }} to role {{ role }};
  grant select on future views in schema {{ schema }} to role {{ role }};
  {% endset %}

  {{ log('Granting select on all and future tables/views in schema ' ~ schema ~ ' to role ' ~ role, info=True) }}
  {% do run_query(sql) %}
  {{ log('Privileges granted successfully', info=True) }}

{% endmacro %}