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

![1.1](https://github.com/user-attachments/assets/56a5dad2-6158-445b-95cf-c1e8f9b5e553)

<img width="254" alt="image" src="https://github.com/user-attachments/assets/a9e6e7d7-069c-46fb-9d37-109f671157c7">


- **Companies with the highest number of layoffs in a single event**

![1.2](https://github.com/user-attachments/assets/1310559f-5816-44ec-a099-b67882a1d19a)

<img width="226" alt="image" src="https://github.com/user-attachments/assets/bd874dd2-1568-4373-9937-40050512bb23">



### 2. What are the yearly trends in layoffs from 2020 to 2023?
- **Number of layoffs by year**

![2.1](https://github.com/user-attachments/assets/f240a903-4dfe-4427-a568-8e82462c5f4c)
<img width="388" alt="image" src="https://github.com/user-attachments/assets/2823b2d8-0abe-479b-b637-830767924613">


- **Ranking companies by number of layoffs for each year**

![2.2](https://github.com/user-attachments/assets/949d674a-c32f-4acc-9f15-76eca6e12a2a)
<img width="435" alt="image" src="https://github.com/user-attachments/assets/d249d6d4-4f3f-4118-811a-b32a57196504">



### 3. Which industries experienced the highest number of layoffs?
- **Number of layoffs per industry**

![3.1](https://github.com/user-attachments/assets/ca5b7398-f84b-4986-800e-ba78e1ee3afb)
<img width="342" alt="image" src="https://github.com/user-attachments/assets/5c9c7fdd-8bee-4cc5-ba39-a79aebfbce02">


- **Top 3 industries in each year that laid off their employees**

![3.2](https://github.com/user-attachments/assets/9b0217a2-8b8c-4296-b2eb-500029756a5b)
<img width="471" alt="image" src="https://github.com/user-attachments/assets/6c413657-59ca-4a89-adc5-efbb67aef31d">



### 4. How does the geographical distribution of layoffs vary across different countries?
- **Number of layoffs by country**

![4.1](https://github.com/user-attachments/assets/16acf08f-a100-40fe-bad2-871bb807c6e7)
<img width="400" alt="image" src="https://github.com/user-attachments/assets/f32572ab-2ab1-459d-a411-8c189b664980">


- **The percentage companies that closed down because of the layoffs, per country**

![4.2](https://github.com/user-attachments/assets/387db61c-5d1a-47de-8d0c-c5a114ee54c9)
<img width="594" alt="image" src="https://github.com/user-attachments/assets/a9e0d223-8178-4173-a149-350d02cd7a06">



### 5. How do layoffs differ across various stages of company maturity?
- **Number of layoffs and companies per business stage**

![5.1](https://github.com/user-attachments/assets/9eea5233-9b16-4e2e-82d5-bd44b60693de)
<img width="390" alt="image" src="https://github.com/user-attachments/assets/9efc324c-f584-481b-a5d8-67bc2c15fdd5">


- **The percentage companies that closed down because of the layoffs, per business stage**

![5.1](https://github.com/user-attachments/assets/ed330d03-f596-4046-9ab2-8db1f9d5cb40)
<img width="618" alt="image" src="https://github.com/user-attachments/assets/03a37eec-0a82-436d-b4f7-0341562e1cae">



## Key Insights
A total of 383,159 employees were laid off across 1,995 layoff events.
The Consumer industry was the most affected, with 45,182 layoffs.
The United States had the highest layoffs, accounting for over 256,000 employees.
Post-IPO companies experienced the largest layoffs, with 204,132 employees affected.
Despite significant fundraising, companies raised an average of $875.1 million before conducting layoffs.


