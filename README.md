# USA Mortality Data Analysis

## Overview

This repository contains a detailed analysis of mortality data sourced from the CDC (Centers for Disease Control and Prevention) for the year 2015. The project utilizes SQL and Python to explore, clean, and analyze the data, uncovering critical insights related to mortality trends, demographic impacts, and socio-economic factors influencing health outcomes.

## Purpose

The primary objectives of this analysis are to answer the following key business questions:

1. **What are the leading causes of death segmented by age groups, gender, and race?**
2. **How do mortality trends for specific conditions change over time?**
3. **What seasonal patterns can be observed in homicide-related deaths?**
4. **What is the average age of mortality based on various conditions, gender, and ethnicity?**
5. **How do lifestyle-related factors compare to non-lifestyle-related factors in terms of mortality?**
6. **What impact do socio-economic factors, such as education and marital status, have on mortality rates?**

## Dataset Description

The dataset utilized in this analysis comprises:
- **2015_data.csv**: A CSV file containing mortality data for 2015.
- **2005_codes.json**: A JSON file with coding information from 2005, aiding in the categorization of various mortality causes.

## Getting Started

To run this project and replicate the analysis, please follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/repo-name.git

2. **Install Required Packages**: Ensure you have the necessary Python packages installed. You can do this via pip:
   ```bash
   pip install pandas sqlalchemy pymysql
3. **Set Up Database:**
a. Ensure you have a MySQL database set up and configured.
b. Update the database connection string in the code with your credentials.

4. **Run the Analysis**: Execute the Python scripts provided in this repository to perform data cleaning, transformation, and analysis.
