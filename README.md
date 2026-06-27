# 🎬 Film Database Design and Implementation

## 📌 Project Overview

This project is a relational database system built using PostgreSQL based on a film dataset. It involves database design, normalization, data cleaning, constraint handling, SQL querying, and data analysis.

The goal is to transform raw CSV data into a structured relational database and perform meaningful analysis using SQL.

---

## 🛠️ Tech Stack

* PostgreSQL
* SQL (DDL, DQL)
* pgAdmin
* Excel (data cleaning)
* draw.io (ER diagram & logical model)

---

## 🧱 Database Design

The database consists of four main tables:

* films
* people
* reviews
* roles

Relationships:

* films ↔ people is a many-to-many relationship resolved using the `roles` table
* films ↔ reviews is one-to-many

---

## 🧹 Data Cleaning

Before importing into PostgreSQL, several data quality issues were handled:

* Invalid UTF-8 encoding characters
* Inconsistent date formats (converted to YYYY-MM-DD)
* Missing foreign keys (film_id not found in films table)
* Logical inconsistency (deathdate earlier than birthdate)
* NULL values violating NOT NULL constraints

---

## 🧪 SQL Analysis

The project includes SQL queries such as:

* Films with more than 5 reviews
* Number of films per actor
* Aggregation and grouping queries
* JOIN operations across multiple tables

---

## 📊 Outputs

All SQL query results are included as screenshots in the project report.

---

## 📁 Files Included

* SQL scripts (DDL & queries)
* Cleaned CSV datasets
* ER diagram and logical model
* PostgreSQL backup file

---

## 📌 Key Learning Outcomes

* Database normalization (up to 3NF)
* Handling real-world messy data
* SQL querying and relational operations
* Understanding referential integrity and constraints

---

## 👤 Author

Eason Jiang
