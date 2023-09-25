with payments as (
    select * from {{ ref('stg_payments') }}
)

select
    *

from payments

where payment_method NOT IN ('credit_card', 'coupon', 'bank_transfer', 'gift_card')