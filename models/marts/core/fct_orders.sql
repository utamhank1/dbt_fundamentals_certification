with
    fct_orders as (
        select
            orders.order_id, orders.customer_id, payments."amount"
        from {{ ref("stg_orders") }} as orders
        join {{ ref("stg_payments") }} as payments on orders.order_id = payments."order_id"
    )

select *
from fct_orders
