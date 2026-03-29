
with google_campaigns as (
    select
        distinct
         cast(account_id as string) as account_id,
        cast(account_name as string) as account_name,
        cast(campaign_name as string) as campaign_name,
        cast(platform as string) as platform
    from {{ ref('google_ads__logs') }}
),

meta_campaigns as (
    select
        distinct
        -- Meta mein ID nahi thi toh hum name ko ID bana sakte hain ya hash generate kar sakte hain
        cast(account_id as string) as account_id,
        cast(account_name as string) as account_name,
        cast(campaign_name as string) as campaign_name,
        cast(platform as string) as platform
    from {{ ref('meta_ads__logs') }}
),

combined_dims as (
    select * from google_campaigns
    union all
    select * from meta_campaigns
)

select * from combined_dims