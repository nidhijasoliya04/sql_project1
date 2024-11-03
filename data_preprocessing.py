# Import necessary libraries
import pandas as pd
import json
from sqlalchemy import create_engine

# Define the path to the data folder
DATA_PATH = '/path_to_folder'

# Load the CSV data for 2015
data = pd.read_csv(f'{DATA_PATH}/2015_data.csv')

# Display the shape of the DataFrame
print(f'Data shape: {data.shape}')

# Check for missing values in the dataset
missing_values = data.isna().sum()
print(f'Missing values in each column:\n{missing_values}')

# Load the 2005 codes from a JSON file
with open(f'{DATA_PATH}/2005_codes.json') as f:
    codes_2005 = json.load(f)

# Identify columns in the DataFrame that are not present in the codes_2005
columns_not_in_codes = [col for col in data.columns if col not in codes_2005]
print(f'Columns not in codes: {columns_not_in_codes}')

# Drop columns not present in the 2005 codes
data.drop(columns=columns_not_in_codes, inplace=True)

# Check for missing values again after dropping columns
missing_values_after_dropping = data.isna().sum()
print(f'Missing values after dropping columns:\n{missing_values_after_dropping}')

# Fill missing flags with zero
flags_to_fill = ['race_imputation_flag', 'bridged_race_flag', 'age_substitution_flag']
for flag in flags_to_fill:
    data[flag] = data[flag].fillna(0)

# Display information about the DataFrame
print(data.info())

# Database connection setup
DATABASE_URI = "mysql+pymysql://root:password@127.0.0.1:3306/sql_health"
engine = create_engine(DATABASE_URI)

# Export the cleaned data to the MySQL database
with engine.connect() as conn:
    data.to_sql('deaths', conn, index=False, if_exists='append')

# Create a dictionary to hold DataFrames for each code in codes_2005
dataframes = {}

# Convert codes_2005 dictionary into DataFrames
for key, value in codes_2005.items():
    df = pd.DataFrame(list(value.items()), columns=['id', 'code'])
    dataframes[key] = df

# Export each DataFrame to the MySQL database
with engine.connect() as conn:
    for dataframe_name, df_to_export in dataframes.items():
        df_to_export.to_sql(dataframe_name, conn, index=False, if_exists='append')
