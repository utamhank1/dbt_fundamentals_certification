with customers as (

    select
        "id" as customer_id,
        "first_name",
        "last_name"

    from DBT_TRAINING.DBT_TEST.CUSTOMERS

)

select * from customers