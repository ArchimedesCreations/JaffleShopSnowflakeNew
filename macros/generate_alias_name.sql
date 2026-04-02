
{% macro generate_alias_name(custom_alias_name=none, node=none) -%}

    {%- if (target.name == 'dev' or env_var('DBT_CLOUD_ENVIRONMENT_TYPE', 'CI') == 'dev') and not(node.resource_type == 'seed') -%}

        {%- set schema_prefix = node.config.schema ~ '_' if node.config.schema else '' -%}

        {%- if custom_alias_name -%}

            {{ schema_prefix }}{{ custom_alias_name | trim }}

        {%- elif node.version -%}

            {{ schema_prefix }}{{ node.name ~ "_v" ~ (node.version | replace(".", "_")) }}

        {%- else -%}

            {{ schema_prefix }}{{ node.name }}

        {%- endif -%}
    
    {%- else -%}

        {%- if custom_alias_name -%}

            {{ custom_alias_name | trim }}

        {%- elif node.version -%}

            {{ return(node.name ~ "_v" ~ (node.version | replace(".", "_"))) }}

        {%- else -%}

            {{ node.name }}

        {%- endif -%}

    {%- endif -%}

    {% if node.resource_type == 'source' %}
        {{ "source is here" }}
    {%- endif -%}

{%- endmacro %}
