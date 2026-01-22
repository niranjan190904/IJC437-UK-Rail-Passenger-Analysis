# UK Rail Passenger Journey Analysis (IJC437)

## Project Overview
This project analyses UK rail passenger journeys using data published by the Office of Rail and Road (ORR).
The aim is to explore long-term trends in rail usage, assess the impact of COVID-19 on passenger journeys,
and compare post-pandemic recovery patterns across major UK rail operators.

## Dataset
- Source: Office of Rail and Road (ORR)
- Table: Passenger journeys by operator (Table 1223)
- Time period: 2011–2025

## Project Setup
This project uses an RStudio Project (`.Rproj`) to manage the working directory.
All file paths in the analysis script are relative to the project root.

To reproduce the analysis:
1. Clone or download the repository.
2. Open the `.Rproj` file in RStudio.
3. Run the script in `scripts/01_exploration.R`.  

## Research Questions
1. How passengers journeys evolved across major UK rail operators after the covid 19?
2. What was the consequences of the covid 19 shock across different operators?
3. What is the major concern of post covid recovery deferred between operators?


## Methods
- Data cleaning and preprocessing (removal of metadata, handling suppressed values)
- Transformation from wide to long format
- Time-series trend analysis
- Pre- and post-COVID comparison
- Linear regression analysis for trend estimation

## Repository Structure
- `scripts/` contains the R script used for data processing and analysis
- `outputs/plots/` contains visualisations generated during the analysis

## How to Run the Code
1. Open the R project in RStudio.
2. Run the script `scripts/01_exploration.R`.
3. All figures will be generated and saved in `outputs/plots/`.


Step 1: 
Download the repository
Option A — Clone with Git (recommended):
git clone https://github.com/[your-username]/IJC437-UK-Rail-Passenger-Analysis.git

Option B — Download ZIP:
Click the green Code button on GitHub.
Select Download ZIP.
Extract the folder to your computer.

Step 2: 
Open the project
Open RStudio:
Go to File > Open Project and select IJC437_Project.Rproj (if created).
Alternatively: Set your working directory to the project folder manually.

Step 3: 
Install required packages (first run only)
Copy and paste this into the R console to install the specific libraries used in this analysis:
install.packages(c("tidyverse", "readxl", "janitor", "stringr", "ggplot2"))

Step 4:
Run the analysis
Open the script scripts/01_exploration.R.
Click the Source button, or run:
source("scripts/01_exploration.R")

Step 5: 
View outputs
After the script finishes, you will find:
Figures: Saved in /outputs/plots/ (e.g., figure1_trends.png, figure3_recovery.png).

Data Objects: The cleaned dataframes (rail_clean, top_ops) will be available in your R Environment.

All outputs are generated automatically from the script using relative file paths.

## Author
Niranjan V
