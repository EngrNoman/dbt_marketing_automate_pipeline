with base_performance as (
    select * from {{ ref('int_marketing__union_performance') }}
),

final_metrics as (
    select
        *,
        -- 1. Click Through Rate (CTR) %
        case 
            when impressions > 0 then round((clicks / impressions) * 100, 2)
            else 0 
        end as ctr_percent,

        -- 2. Cost Per Click (CPC)
        case 
            when clicks > 0 then round(spend / clicks, 2)
            else 0 
        end as cpc,

        -- 3. Cost Per Conversion (CPA)
        case 
            when conversions > 0 then round(spend / conversions, 2)
            else 0 
        end as cost_per_conversion,

        -- 4. Conversion Rate %
        case 
            when clicks > 0 then round((conversions / clicks) * 100, 2)
            else 0 
        end as conversion_rate_percent

    from base_performance
)

select * from final_metrics