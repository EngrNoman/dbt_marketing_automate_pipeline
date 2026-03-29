with source as (
    select * from {{ source('meta_ads_raw', 'meta_ads_logs') }}
),

flattened as (
    select
        -- String Cleaning: Trim aur Lowercase
        trim(lower(client_name)) as account_name,
        ad_account_id as account_id,
        
        -- Campaign Info cleaning
        trim(lower(campaign.name)) as campaign_name,
        campaign.status as campaign_status,
        
        -- Metrics with Null handling
        coalesce(cast(campaign.spend as float64), 0) as spend,
        coalesce(cast(campaign.clicks as int64), 0) as clicks,
        coalesce(cast(campaign.impressions as int64), 0) as impressions,
        coalesce(cast(campaign.conversions as float64), 0) as conversions

    from source,
    unnest(campaigns) as campaign
),

renamed as (
    select
        account_id,
        account_name,
        'Meta' as platform,
        campaign_name,
        campaign_status,
        spend,
        clicks,
        impressions,
        conversions
    from flattened
)

select * from renamed