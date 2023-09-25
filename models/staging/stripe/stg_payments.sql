with payments as (

    select
        "id" as customer_id,
        "order_id",
        "payment_method",
        "amount"

    from DBT_TRAINING.DBT_TEST.PAYMENTS

)

select * from payments