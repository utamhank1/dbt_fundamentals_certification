with
    customers as (select * from {{ ref("stg_customers") }}),

    orders as (select * from {{ ref("stg_orders") }}),

    fct_orders as (select * from {{ ref("fct_orders") }}),

    stg_payments as (select * from {{ ref("stg_payments") }}),

    per_customer_spend as (
        select fct_orders.customer_id, sum(fct_orders."amount") / 100 as total_spend
        from stg_payments
        join fct_orders on stg_payments.customer_id = fct_orders.customer_id
        group by fct_orders.customer_id
    ),

    customer_orders as (

        select
            customer_id,

            min("order_date") as first_order_date,
            max("order_date") as most_recent_order_date,
            count(order_id) as number_of_orders

        from orders

        group by 1

    ),

    final as (

        select
            customers.customer_id,
            customers."first_name",
            customers."last_name",
            customer_orders.first_order_date,
            customer_orders.most_recent_order_date,
            coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
            coalesce(per_customer_spend.total_spend, 0) as lifetime_value

        from customers

        left join customer_orders using (customer_id)
        left join per_customer_spend using (customer_id)

    )

select *
from final
