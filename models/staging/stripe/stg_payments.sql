with payments as (

    select
        "id" as customer_id,
        "order_id",
        "payment_method",
        "amount"

    from {{ source("stripe", "payments") }}

)

select * from payments