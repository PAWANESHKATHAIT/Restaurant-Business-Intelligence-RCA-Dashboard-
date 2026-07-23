import os
import mysql.connector

# =========================== CONFIG ===========================
DB_CONFIG = {
    "host": "127.0.0.1",
    "port": 3306,
    "user": "root",
    "password": "Kathait@1122",   # <-- change this
    "database": "restaurant_bi",
    "allow_local_infile": True,
}

# Folder where the 3 CSVs are saved on your PC.
# Use forward slashes (/) even on Windows.
CSV_FOLDER = "C:/Users/pawan/OneDrive/Desktop/SQL Test"   # <-- change this, or ignore if using full paths below
# ================================================================

FILES = [
    {
        "csv": "Business_Performance.csv",
        "table": "stg_business_performance",
        "columns": [
            "Date", "Outlet_ID", "Outlet_Name", "City", "Cuisine", "Sales",
            "Delivered_Orders", "Average_Rating", "Impressions", "Menu_Opens",
            "Cart_Builds", "Placed_Orders", "Breakfast_Orders", "Lunch_Orders",
            "Snacks_Orders", "Dinner_Orders", "Late_Night_Orders",
            "Market_Share_Percentage", "KPT", "Online_Percentage",
            "Discounts_Given", "Unused_Column_A", "Unused_Column_B",
            "Ad_Sales", "Ad_Spend",
        ],
    },
    {
        "csv": "Ads_Performance.csv",
        "table": "stg_ads_performance",
        "columns": [
            "Date", "Outlet_ID", "Campaign_ID", "Product_Type", "Targeting",
            "Segment", "Keyword", "Ad_Sales", "Ad_Spend", "Unused_Meta_Data",
        ],
    },
    {
        "csv": "Customer_Master.csv",
        "table": "stg_customer_master",
        "columns": [
            "Customer_ID", "Outlet_ID", "Customer_Name", "Gender", "City",
            "Membership_Type", "Join_Date", "Customer_Status", "Unused_Flag",
        ],
    },
]


def check_header(csv_path, expected_columns):
    """Read just the header row and compare it to what we expect.
    Returns (True, None) if it matches, or (False, actual_header) if not."""
    with open(csv_path, "r", encoding="utf-8-sig") as fh:
        first_line = fh.readline().strip()
    actual = [c.strip() for c in first_line.split(",")]
    expected = [c.strip() for c in expected_columns]
    if actual == expected:
        return True, actual
    return False, actual


def main():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()

    # make sure server-side local_infile is on too
    cursor.execute("SET GLOBAL local_infile = 1;")

    # clear out any leftover/partial data from earlier attempts
    for f in FILES:
        cursor.execute(f"TRUNCATE TABLE {f['table']};")
    conn.commit()
    print("Cleared existing rows from all 3 staging tables.\n")

    for f in FILES:
        if "/" in f["csv"] or "\\" in f["csv"]:
            csv_path = f["csv"].replace("\\", "/")
        else:
            csv_path = os.path.join(CSV_FOLDER, f["csv"]).replace("\\", "/")

        if not os.path.exists(csv_path):
            print(f"!! File not found, skipping: {csv_path}")
            continue

        ok, actual_header = check_header(csv_path, f["columns"])
        if not ok:
            print(f"\n!! HEADER MISMATCH for {f['csv']} — skipping this file.")
            print(f"   Expected ({len(f['columns'])} cols): {f['columns']}")
            print(f"   Actual   ({len(actual_header)} cols): {actual_header}")
            print("   Column names/order don't match this table's schema.\n")
            continue

        col_list = ", ".join(f["columns"])
        query = f"""
            LOAD DATA LOCAL INFILE '{csv_path}'
            INTO TABLE {f['table']}
            FIELDS TERMINATED BY ','
            OPTIONALLY ENCLOSED BY '"'
            LINES TERMINATED BY '\\n'
            IGNORE 1 LINES
            ({col_list});
        """
        print(f"Loading {f['csv']} -> {f['table']} ...")
        cursor.execute(query)
        conn.commit()
        print(f"  done. Rows affected: {cursor.rowcount}")

    # verify counts
    print("\n--- Row counts ---")
    for f in FILES:
        cursor.execute(f"SELECT COUNT(*) FROM {f['table']};")
        count = cursor.fetchone()[0]
        print(f"{f['table']}: {count}")

    cursor.close()
    conn.close()
    print("\nAll done.")


if __name__ == "__main__":
    main()