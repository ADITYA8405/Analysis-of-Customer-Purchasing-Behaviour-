Customer Behaviour Analysis

---- Project Overview

This project is an end-to-end Customer Behaviour Analysis project
built to understand how customers purchase products, interact with
discounts, use different payment methods, and behave across product
categories, seasons, and subscription statuses.

The project follows a practical data-analytics workflow:

Raw CSV Data → Python/Pandas → PostgreSQL/SQL Analysis → Power BI
Dashboard

The goal was not only to analyze the data, but to demonstrate how
multiple tools used by a Data Analyst work together in a real-world
analytics pipeline.

🎯 Problem Statement

A retail business has collected customer purchase and behavioural data
containing information such as:

Customer demographics

Products purchased

Product categories

Purchase amounts

Locations

Seasons

Discounts

Subscription status

Payment methods

Purchase frequency

Previous purchases

Review ratings

Shipping preferences

Promotional-code usage

However, raw transactional data by itself does not provide clear
business insights.

The business needs answers to questions such as:

How much revenue is being generated?

How many customers/purchases are represented in the dataset?

What is the average purchase value?

Which product categories generate the most revenue?

Which products receive discounts most frequently?

Does subscription status relate to customer spending?

Which payment methods are most commonly used?

How does purchasing behaviour vary by season?

Which products are most popular?

How frequently do customers make purchases?

What customer behaviours could be useful for business
decision-making?

Objective

The objective of this project was to clean, analyze, query, and
visualize customer behaviour data to convert raw data into actionable
business insights.

🛠️ Tools & Technologies

Tool                   Purpose

Python             Data loading, inspection and preparation
Pandas             Data manipulation and exploratory analysis
Jupyter Notebook   Interactive Python analysis
PostgreSQL         Storing structured data and performing SQL analysis
SQL                Business queries, aggregations and analysis
Power BI           Interactive visualization and dashboard creation
DAX                Creating reusable analytical measures in Power BI

🔄 Project Workflow

                  RAW CSV DATA
                       │
                       ▼
              ┌─────────────────┐
              │ Python + Pandas │
              │ Data Inspection  │
              │ & Preparation    │
              └────────┬────────┘
                       │
                       ▼
                ┌──────────────┐
                │  PostgreSQL  │
                │              │
                │ Data Storage │
                └──────┬───────┘
                       │
                       ▼
                 ┌────────────┐
                 │    SQL     │
                 │  Analysis  │
                 └─────┬──────┘
                       │
                       ▼
                ┌──────────────┐
                │   Power BI   │
                │  Dashboard   │
                └──────┬───────┘
                       │
                       ▼
                BUSINESS INSIGHTS

1. 🐍 Python & Pandas

The first stage of the project was performed using Python in Jupyter
Notebook.

Pandas was used to load the CSV file into a DataFrame.

import pandas as pd

df = pd.read_csv("customer_behaviour.csv")

The DataFrame was then inspected to understand:

Number of rows and columns

Column names

Data types

Missing values

Duplicate records

Basic statistical information

Categorical and numerical variables

Typical exploratory commands included:

df.head()
df.shape
df.columns
df.info()
df.describe()
df.isnull().sum()
df.duplicated().sum()

Why Python was used

Python was useful during the initial stage because it made it easy to
quickly inspect the dataset and understand its structure before loading
it into the database.

Pandas also provides convenient tools for:

Cleaning data

Transforming columns

Handling missing values

Detecting duplicates

Performing exploratory analysis

2. 🗄️ PostgreSQL

After inspecting the dataset, the data was loaded into PostgreSQL.

The CSV data was transferred from the Pandas DataFrame into a PostgreSQL
table.

A Python connection was created using SQLAlchemy:

from sqlalchemy import create_engine

engine = create_engine(
    f'postgresql://{username}:{password}@{host}:{port}/{database}'
)

The DataFrame was then loaded into PostgreSQL:

df.to_sql(
    table_name,
    engine,
    if_exists='replace',
    index=False
)

This created a structured database table that could then be queried
using SQL.

3. 🧮 SQL Analysis

Once the data was stored in PostgreSQL, SQL was used to answer business
questions.

Instead of manually inspecting thousands of rows, SQL was used to
calculate aggregations and identify patterns.

Important SQL concepts used in the project included:

SELECT

WHERE

GROUP BY

ORDER BY

LIMIT

COUNT()

SUM()

AVG()

ROUND()

CASE WHEN

Aggregate calculations

Example: Customer Spending by Subscription Status

One analysis compared customers based on their subscription status.

SELECT
    subscription_status,
    COUNT(customer_id) AS total_customers,
    ROUND(AVG(purchase_amount), 2) AS avg_spend,
    ROUND(SUM(purchase_amount), 2) AS total_revenue
FROM customer
GROUP BY subscription_status
ORDER BY total_revenue DESC, avg_spend DESC;

Business purpose

This analysis helps determine whether subscribed and non-subscribed
customers behave differently in terms of:

Customer volume

Average spending

Total revenue contribution

This can help evaluate the potential value of a customer subscription
program.

Example: Products With the Highest Discount Rate

Another important analysis calculated the percentage of purchases where
a discount was applied.

SELECT
    item_purchased,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN discount_applied = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS discount_rate
FROM customer
GROUP BY item_purchased
ORDER BY discount_rate DESC
LIMIT 5;

Business purpose

This identifies products that are most frequently purchased with
discounts.

This can help the business investigate:

Which products depend heavily on discounts

Where promotional campaigns are most common

Whether certain products may have weaker organic demand

Potential opportunities to optimize discount strategies

4. 📈 Power BI

After the data was prepared and analyzed, Power BI was used to
create the visualization layer.

The purpose of Power BI was to transform numerical results into an
interactive dashboard that can be understood quickly by business users.

The dataset was brought into Power BI and a semantic model was created.

📐 DAX Measures

Instead of relying only on automatically generated aggregations,
reusable DAX measures were created.

Examples include:

Number of Customers

Number of Customers =
COUNT('customer'[customer_id])

Average Purchase Amount

Average Purchase Amount =
AVERAGE('customer'[purchase_amount])

Average Review Rating

Average Review Rating =
AVERAGE('customer'[review_rating])

Total Revenue

Total Revenue =
SUM('customer'[purchase_amount])

Measures allow calculations to respond dynamically to filters and visual
context in Power BI.

For example, the same Total Revenue measure can be used to display:

Overall revenue

Revenue by category

Revenue by season

Revenue by product

Revenue by gender

Revenue after applying dashboard filters

📊 Dashboard & Visualizations


<img width="1094" height="619" alt="Screenshot 2026-09-30 at 3 35 30 AM" src="https://github.com/user-attachments/assets/dbad6874-5a19-4dca-aa21-7c91ab318397" />


The Power BI report was designed to provide a high-level overview of
customer behaviour and then allow deeper analysis.

The dashboard can include KPI cards such as:

Total Revenue

Number of Customers

Average Purchase Amount

Average Review Rating

Additional visualizations can be used to analyze:

Revenue Analysis

Revenue by product category

Revenue by individual product

Revenue by season

Revenue by location

Customer Analysis

Customer/subscription status

Customer distribution by gender

Purchase frequency

Previous purchase behaviour

Discount Analysis

Discount usage

Discount rate by product

Promotional-code usage

Product Analysis

Most frequently purchased products

Top products by revenue

Product/category performance

Payment & Shopping Behaviour

Payment method distribution

Shipping preferences

Purchase behaviour across customer segments

🔍 Key Analytical Questions

The project was designed around business-oriented questions rather than
simply displaying raw data.

Some of the questions investigated include:

How many customers are represented in the dataset?

What is the total revenue?

What is the average purchase amount?

What is the average customer review rating?

How does spending differ by subscription status?

Which products have the highest percentage of discounted purchases?

Which categories generate the highest revenue?

Which products are purchased most frequently?

How does customer behaviour vary across seasons?

Which payment methods are most commonly used?

How does purchase frequency vary among customers?

What patterns can be observed between promotions and purchasing
behaviour?

💡 Business Value

The main value of the project is the conversion of raw customer data
into information that could support business decisions.

For example, the analysis can help a retail business:

Identify high-performing product categories

Understand customer spending patterns

Evaluate subscription-program performance

Identify products heavily dependent on discounts

Understand seasonal purchasing behaviour

Improve promotional strategies

Identify popular products

Understand payment preferences

Monitor customer engagement

Build more targeted marketing strategies

🧠 What I Learned

This project provided practical experience with an end-to-end data
analytics workflow.

Python

Learned how to:

Load CSV data

Work with Pandas DataFrames

Inspect datasets

Understand data types

Perform basic data-quality checks

Connect Python with PostgreSQL

SQL

Practiced:

Filtering and grouping data

Aggregate functions

Conditional logic

Business-oriented analysis

Revenue calculations

Percentage calculations

Ranking and top-N analysis

PostgreSQL

Learned how to:

Create and manage databases/tables

Store analytical datasets

Connect PostgreSQL with Python

Execute SQL queries against structured data

Power BI

Learned how to:

Import data

Build a semantic model

Create DAX measures

Create KPI cards

Build charts and dashboards

Turn analytical results into business-friendly visualizations

🏗️ Skills Demonstrated

This project demonstrates practical knowledge of:

Data Analysis

Exploratory Data Analysis

Python

Pandas

SQL

PostgreSQL

SQLAlchemy

Jupyter Notebook

Power BI

DAX

Data Visualization

KPI Development

Business Problem Solving

Analytical Thinking

📁 Suggested Project Structure

customer-behaviour-analysis/
│
├── data/
│   └── customer_behaviour.csv
│
├── notebooks/
│   └── customer_behaviour_analysis.ipynb
│
├── sql/
│   └── customer_analysis.sql
│
├── powerbi/
│   └── customer_behaviour_dashboard
│
└── README.md

🚀 End-to-End Summary

The project follows a complete analytics pipeline:

CSV
 ↓
Python / Pandas
 ↓
Data Inspection & Preparation
 ↓
PostgreSQL
 ↓
SQL Business Analysis
 ↓
Power BI
 ↓
DAX Measures
 ↓
Interactive Dashboard
 ↓
Business Insights

The project demonstrates how a Data Analyst can move from raw data →
structured data → analysis → visualization → business insights using a
combination of Python, SQL, PostgreSQL, and Power BI.

👤 Project Type

Data Analytics / Business Intelligence Project

Technologies

Python Pandas Jupyter Notebook PostgreSQL SQL SQLAlchemy
Power BI DAX

⭐ Conclusion

The Customer Behaviour Analysis project demonstrates a practical,
end-to-end approach to solving a business analytics problem.

Python was used for data handling and preparation, PostgreSQL and
SQL were used for structured storage and analytical querying, and
Power BI was used to communicate insights through an interactive
dashboard.

Together, these tools form a realistic workflow used in modern
data-analytics environments.
