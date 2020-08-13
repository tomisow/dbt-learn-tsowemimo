{% set payment_method = dbt_utils.get_column_values(table=ref('stg_payments'), column='payment_method', max_records=50, default=[]) %}

select 
    order_id,
    {% for payment in payment_method %} sum(case when payment_method = '{{ payment }}' then amount else 0 end) as {{ payment }}_amount {% if not loop.last %},
    {% endif %}
    {% endfor %}
from {{ ref('stg_payments')}}
group by 1