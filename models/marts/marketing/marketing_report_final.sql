with fact_perf as (
    -- Fact table se metrics aur calculations uthana
    select * from {{ ref('fct_marketing_performance') }}
),

dim_camp as (
    -- Dimension table se attributes (Status, Channel) uthana
    select * from {{ ref('dim_campaigns') }}
),

final_joined as (
    select
        -- Common Columns (Grain)
        f.account_id,
        f.account_name,
        f.platform,
        f.campaign_name,
        
       

        -- Raw Metrics from Fact Table
        f.spend,
        f.clicks,
        f.impressions,
        f.conversions,

        -- Calculated Metrics (KPIs) from Fact Table
        f.cpc,
        f.ctr_percent,
        f.cost_per_conversion,
        f.conversion_rate_percent

    from fact_perf f
    left join dim_camp d 
        on f.campaign_name = d.campaign_name 
        and f.platform = d.platform
)

select * from final_joined