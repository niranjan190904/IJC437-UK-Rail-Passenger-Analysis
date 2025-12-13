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
1. How have UK rail passenger journeys changed over time, particularly around the COVID-19 period?
2. To what extent have major UK rail operators recovered passenger journeys after COVID-19?
3. Are there differences in recovery patterns between operators?

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

## Author
Niranjan V
