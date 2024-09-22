# Worldwide Layoffs: Data Cleaning and Exploration using MySQL
This SQL project comprises Data Cleaning in the first part and Exploratory Data Analysis (EDA) in the second part.

## Overview
This project focuses on cleaning and analyzing a dataset of worldwide layoffs that occurred between 2020 and 2023. The dataset covers 2,361 records from 1,628 companies globally, detailing the number of layoffs, the percentage of workforce reductions, the affected industries, and more. The primary goals of the project are to clean the raw data and perform exploratory data analysis (EDA) to uncover insights into global job market trends during this period.


## About the Dataset
The dataset was scraped from Layoffs.fyi and contains the following variables:

- Company: Name of the company where layoffs occurred.
- Location: City/region where the company is located.
- Industry: The industry to which the company belongs.
- Total Laid Off: Total number of employees laid off.
- Percentage Laid Off: Percentage of the workforce that was laid off.
- Date: The date when layoffs were announced.
- Stage: The maturity stage of the company (e.g., startup, public).
- Country: The country where the layoffs occurred.
- Funds Raised (Millions): Total funds raised by the company.

The dataset originally contained 2,361 records, but after cleaning, it was reduced to 1,995 records, providing a clearer and more reliable picture for analysis.


## Data Cleaning Process
The data cleaning process was essential to ensure accuracy and consistency for the EDA. Below are the key steps involved:

1. Create a Staging Table: Worked on a temporary table to avoid altering the original dataset.
2. Remove Duplicates: Identified and eliminated duplicate rows to ensure data integrity.
3. Handle Missing Values: Dealt with null values by using appropriate imputation techniques or removing records where necessary.
4. Standardize Data: Standardized the format for all columns (e.g., dates, text) to ensure consistency.
5. Remove Unnecessary Columns: Dropped rows and columns that were not relevant for the analysis.
6. Cleaned Final Dataset: Resulted in a clean dataset of 1,995 records, suitable for analysis.


## Exploratory Data Analysis (EDA)

The cleaned dataset was analyzed to identify trends and insights related to layoffs. The following research questions guided the analysis:

### 1. How do layoff statistics vary across different companies?

- **Total layoffs by company**
<img src="Images/p1.1.png">
<img width="254" src="Images/r1.1.png">

- **Companies with the highest number of layoffs in a single event**
<img src="Images/p1.2.png">
<img width="226" src="Images/r1.2.png">


### 2. What are the yearly trends in layoffs from 2020 to 2023?

- **Number of layoffs by year**
<img src="Images/p2.1.png">
<img width="388" src="Images/r2.1.png">

- **Ranking companies by number of layoffs for each year**
<img src="Images/p2.2.png">
<img width="435" src="Images/r2.2.png">


### 3. Which industries experienced the highest number of layoffs?

- **Number of layoffs per industry**
<img src="Images/p3.1.png">
<img width="342" src="Images/r3.1.png">

- **Top 3 industries in each year that laid off their employees**
<img src="Images/p3.2.png">
<img width="471" src="Images/r3.2.png">


### 4. How does the geographical distribution of layoffs vary across different countries?

- **Number of layoffs by country**
<img src="Images/p4.1.png">
<img width="400" src="Images/r4.1.png">

- **The percentage companies that closed down because of the layoffs, per country**
<img src="Images/p4.2.png">
<img width="594" src="Images/r4.2.png">


### 5. How do layoffs differ across various stages of company maturity?

- **Number of layoffs and companies per business stage**
<img src="Images/p5.1.png">
<img width="390" src="Images/r5.1.png">

- **The percentage companies that closed down because of the layoffs, per business stage**
<img src="Images/p5.2.png">
<img width="618" src="Images/r5.2.png">


## Key Insights
A total of 383,159 employees were laid off across 1,995 layoff events.
The Consumer industry was the most affected, with 45,182 layoffs.
The United States had the highest layoffs, accounting for over 256,000 employees.
Post-IPO companies experienced the largest layoffs, with 204,132 employees affected.
Despite significant fundraising, companies raised an average of $875.1 million before conducting layoffs.


