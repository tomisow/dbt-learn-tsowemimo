with payments as (
    select * from {{ ref('stg_payments') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
)

select payments.order_id,
        orders.customer_id,
        orders.order_date,
        sum(payments.amount) as amount
from orders
left join payments on payments.order_id = orders.order_id
where payment_status = 'success'
group by 1, 2, 3