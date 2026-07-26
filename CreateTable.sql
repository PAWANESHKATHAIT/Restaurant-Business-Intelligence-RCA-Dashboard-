CREATE DATABASE IF NOT EXISTS restaurant_bi
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE restaurant_bi;

DROP TABLE IF EXISTS stg_business_performance;
CREATE TABLE stg_business_performance (
    Date                     VARCHAR(20),
    Outlet_ID                VARCHAR(20),
    Outlet_Name              VARCHAR(150),
    City                     VARCHAR(50),
    Cuisine                  VARCHAR(50),
    Sales                    VARCHAR(30),
    Delivered_Orders         VARCHAR(20),
    Average_Rating           VARCHAR(20),
    Impressions               VARCHAR(20),
    Menu_Opens                VARCHAR(20),
    Cart_Builds               VARCHAR(20),
    Placed_Orders             VARCHAR(20),
    Breakfast_Orders          VARCHAR(20),
    Lunch_Orders              VARCHAR(20),
    Snacks_Orders             VARCHAR(20),
    Dinner_Orders             VARCHAR(20),
    Late_Night_Orders         VARCHAR(20),
    Market_Share_Percentage   VARCHAR(20),
    KPT                       VARCHAR(20),
    Online_Percentage         VARCHAR(20),
    Discounts_Given           VARCHAR(30),
    Unused_Column_A           VARCHAR(50),
    Unused_Column_B           VARCHAR(50),
    Ad_Sales                  VARCHAR(30),
    Ad_Spend                  VARCHAR(30)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS stg_ads_performance;
CREATE TABLE stg_ads_performance (
    Date              VARCHAR(20),
    Outlet_ID         VARCHAR(20),
    Campaign_ID       VARCHAR(30),
    Product_Type      VARCHAR(50),
    Targeting         VARCHAR(50),
    Segment           VARCHAR(50),
    Keyword           VARCHAR(100),
    Ad_Sales          VARCHAR(30),
    Ad_Spend          VARCHAR(30),
    Unused_Meta_Data  VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS stg_customer_master;
CREATE TABLE stg_customer_master (
    Customer_ID       VARCHAR(20),
    Outlet_ID         VARCHAR(20),
    Customer_Name     VARCHAR(100),
    Gender            VARCHAR(20),
    City              VARCHAR(50),
    Membership_Type   VARCHAR(20),
    Join_Date         VARCHAR(20),
    Customer_Status   VARCHAR(20),
    Unused_Flag       VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;