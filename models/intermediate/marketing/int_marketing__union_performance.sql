with google_ads as (
    select 
        cast(account_id as string) as account_id,
        cast(account_name as string) as account_name,
        cast(campaign_name as string) as campaign_name,
        cast(platform as string) as platform,
        -- Metrics (Dono mein common hain)
        cast(spend as float64) as spend,
        cast(clicks as int64) as clicks,
        cast(impressions as int64) as impressions,
        cast(conversions as float64) as conversions
    from {{ ref('google_ads__logs') }}
),

meta_ads as (
    select 
        cast(account_id as string) as account_id,
        cast(account_name as string) as account_name,
        cast(campaign_name as string) as campaign_name,
        cast(platform as string) as platform,
        -- Metrics (Dono mein common hain)
        cast(spend as float64) as spend,
        cast(clicks as int64) as clicks,
        cast(impressions as int64) as impressions,
        cast(conversions as float64) as conversions
    from {{ ref('meta_ads__logs') }}
),

union_all as (
    select * from google_ads
    union all
    select * from meta_ads
)

select * from union_all