with source as (
    -- Raw source se data uthana
    select * from {{ source('google_ads_raw', 'google_ads_log') }}
),

renamed as (
    select
        -- Account Info
        customer.id as account_id,
        trim(customer.descriptiveName) as account_name, -- Faltu spaces khatam
        customer.currencyCode as currency,

        -- Campaign Info
        campaign.id as campaign_id,
        -- Campaign name ko lowercase aur trim karna takay Meta Ads se match ho sakay
        trim(lower(campaign.name)) as campaign_name,
        campaign.status as campaign_status,
        lower(campaign.advertisingChannelType) as channel,

        -- Dates & Segments
        cast(segments.date as date) as report_date,
        lower(segments.device) as device, -- 'MOBILE' -> 'mobile'

        -- Metrics (The Math part with Null Handling)
        -- Coalesce use kiya hai takay agar data missing ho toh calculation error na aaye
        coalesce(cast(metrics.clicks as int64), 0) as clicks,
        coalesce(cast(metrics.impressions as int64), 0) as impressions,
        
        -- Micros conversion:
        round(coalesce(cast(metrics.costMicros as float64), 0) / 1000000, 2) as spend,
        coalesce(cast(metrics.conversions as float64), 0) as conversions,

        -- Platform tag (Agle phase mein kaam ayega)
        'Google' as platform

    from source
)

select * from renamed