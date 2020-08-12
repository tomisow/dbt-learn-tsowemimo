with payments as (
    select * from {{ ref('stg_payments') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
)

select payments.order_id,
        orders.customer_id,
        orders.order_date,
        payments.amount
from payments
left join orders on payments.order_id = orders.order_id
where payment_status = 'success'