{% macro generate_schema_name(custom_schema_name, node) -%}
 
    {%- set default_schema = env_var('DBT_SCHEMA', target.schema) -%}

    {# do not override the seed destination #}
    {% if node.resource_type == 'seed' %}
        {{ custom_schema_name | trim }}

    {%- elif  target.name == 'dev' or env_var('DBT_CLOUD_ENVIRONMENT_TYPE', 'CI') == 'dev' -%}

        {{ default_schema }}

    {%- elif custom_schema_name is none  -%}

        {{ default_schema }}

    {%- else -%}

        {{ custom_schema_name | trim }}

    {% endif %}
{%- endmacro %}