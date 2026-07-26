-- business_performance
-- Drop the unused columns
ALTER TABLE stg_business_performance
DROP COLUMN Unused_Column_A,
DROP COLUMN Unused_Column_B;

-- Check missing values
SELECT
    SUM(Date IS NULL OR TRIM(Date) = '')                             AS missing_date,
    SUM(Outlet_ID IS NULL OR TRIM(Outlet_ID) = '')                   AS missing_outlet_id,
    SUM(Outlet_Name IS NULL OR TRIM(Outlet_Name) = '')                AS missing_outlet_name,
    SUM(City IS NULL OR TRIM(City) = '')                             AS missing_city,
    SUM(Cuisine IS NULL OR TRIM(Cuisine) = '')                       AS missing_cuisine,
    SUM(Sales IS NULL OR TRIM(Sales) = '')                           AS missing_sales,
    SUM(Delivered_Orders IS NULL OR TRIM(Delivered_Orders) = '')     AS missing_delivered_orders,
    SUM(Average_Rating IS NULL OR TRIM(Average_Rating) = '')         AS missing_rating,
    SUM(Impressions IS NULL OR TRIM(Impressions) = '')               AS missing_impressions,
    SUM(Menu_Opens IS NULL OR TRIM(Menu_Opens) = '')                 AS missing_menu_opens,
    SUM(Cart_Builds IS NULL OR TRIM(Cart_Builds) = '')               AS missing_cart_builds,
    SUM(Placed_Orders IS NULL OR TRIM(Placed_Orders) = '')           AS missing_placed_orders,
    SUM(Breakfast_Orders IS NULL OR TRIM(Breakfast_Orders) = '')     AS missing_breakfast,
    SUM(Lunch_Orders IS NULL OR TRIM(Lunch_Orders) = '')             AS missing_lunch,
    SUM(Snacks_Orders IS NULL OR TRIM(Snacks_Orders) = '')           AS missing_snacks,
    SUM(Dinner_Orders IS NULL OR TRIM(Dinner_Orders) = '')           AS missing_dinner,
    SUM(Late_Night_Orders IS NULL OR TRIM(Late_Night_Orders) = '')   AS missing_late_night,
    SUM(Market_Share_Percentage IS NULL OR TRIM(Market_Share_Percentage) = '') AS missing_market_share,
    SUM(KPT IS NULL OR TRIM(KPT) = '')                               AS missing_kpt,
    SUM(Online_Percentage IS NULL OR TRIM(Online_Percentage) = '')   AS missing_online_pct,
    SUM(Discounts_Given IS NULL OR TRIM(Discounts_Given) = '')       AS missing_discounts,
    SUM(Ad_Sales IS NULL OR TRIM(Ad_Sales) = '')                     AS missing_ad_sales,
    SUM(Ad_Spend IS NULL OR TRIM(Ad_Spend) = '')                     AS missing_ad_spend
FROM stg_business_performance;

-- ads_performance
ALTER TABLE stg_ads_performance
DROP COLUMN Unused_Meta_Data;

-- Check missing values
SELECT
    SUM(Date IS NULL OR TRIM(Date) = '')                 AS missing_date,
    SUM(Outlet_ID IS NULL OR TRIM(Outlet_ID) = '')       AS missing_outlet_id,
    SUM(Campaign_ID IS NULL OR TRIM(Campaign_ID) = '')   AS missing_campaign_id,
    SUM(Product_Type IS NULL OR TRIM(Product_Type) = '') AS missing_product_type,
    SUM(Targeting IS NULL OR TRIM(Targeting) = '')       AS missing_targeting,
    SUM(Segment IS NULL OR TRIM(Segment) = '')           AS missing_segment,
    SUM(Keyword IS NULL OR TRIM(Keyword) = '')           AS missing_keyword,
    SUM(Ad_Sales IS NULL OR TRIM(Ad_Sales) = '')         AS missing_ad_sales,
    SUM(Ad_Spend IS NULL OR TRIM(Ad_Spend) = '')         AS missing_ad_spend
FROM stg_ads_performance;