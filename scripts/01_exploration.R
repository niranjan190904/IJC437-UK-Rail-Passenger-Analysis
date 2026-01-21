############################################################
# IJC437 – Introduction to Data Science
# UK Rail Passenger Journey Analysis (ORR Table 1223)
# Author: Niranjan
# Description:
# - Data cleaning and preprocessing
# - Trend analysis of passenger journeys
# - COVID impact and recovery analysis
# - Visualisations saved to outputs/plots
# Required packages:
# tidyverse, readxl, janitor, stringr
# These packages must be installed before running this script.
# This script is designed to be run within the RStudio Project.
# File paths are relative to the project root.
############################################################

# -------------------------------
# 1. Load required libraries
# -------------------------------
library(tidyverse)
library(readxl)
library(janitor)
library(stringr)

# -------------------------------
# 2. Load the dataset
# -------------------------------
# ORR Excel files contain metadata rows at the top.
# The actual header starts after these rows.

rail_raw <- read_excel(
  "DATASET/table-1223-passenger-journeys-by-operator.xlsx",
  sheet = "1223_Journeys_by_operator",
  skip = 5
)

# -------------------------------
# 3. Clean column names
# -------------------------------
rail <- clean_names(rail_raw)

# -------------------------------
# 4. Remove footnote columns
# -------------------------------
rail <- rail %>%
  select(-matches("_note_"))

# -------------------------------
# 5. Handle suppressed values and convert to numeric
# -------------------------------
rail <- rail %>%
  mutate(across(-time_period, ~ na_if(.x, "[Z]"))) %>%
  mutate(across(-time_period, as.numeric))

# -------------------------------
# 6. Convert from wide to long format
# -------------------------------
rail_long <- rail %>%
  pivot_longer(
    cols = -time_period,
    names_to = "operator",
    values_to = "journeys_million"
  )

# -------------------------------
# 7. Extract year variable
# -------------------------------
rail_long <- rail_long %>%
  filter(str_detect(time_period, "20\\d{2}")) %>%
  mutate(
    year = as.integer(
      str_extract(time_period, "(20\\d{2})(?!.*20\\d{2})")
    )
  ) %>%
  filter(!is.na(year))

# -------------------------------
# 8. Identify top 6 operators by total journeys
# -------------------------------
top_ops <- rail_long %>%
  group_by(operator) %>%
  summarise(total_journeys = sum(journeys_million, na.rm = TRUE)) %>%
  arrange(desc(total_journeys)) %>%
  slice_head(n = 6) %>%
  pull(operator)

rail_top <- rail_long %>%
  filter(operator %in% top_ops)

# -------------------------------
# 9. Create outputs folder if not exists
# -------------------------------
dir.create("outputs/plots", recursive = TRUE, showWarnings = FALSE)

# -------------------------------
# 10. Plot 1: Time-series trends (Top 6 operators)
# -------------------------------
ggplot(rail_top,
       aes(x = year,
           y = journeys_million,
           colour = operator,
           group = operator)) +
  geom_line(linewidth = 1) +
  scale_x_continuous(breaks = seq(min(rail_top$year),
                                  max(rail_top$year),
                                  by = 1)) +
  labs(
    title = "Top 6 UK Rail Operators: Passenger Journeys Over Time",
    subtitle = "Annual passenger journeys (millions), 2011–2025",
    x = "Year",
    y = "Passenger journeys (million)",
    colour = "Operator"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave(
  "outputs/plots/figure1_top6_trends.png",
  width = 10,
  height = 6,
  dpi = 300
)

# -------------------------------
# 11. COVID recovery analysis
# -------------------------------
covid_summary <- rail_long %>%
  filter(operator %in% top_ops) %>%
  group_by(operator) %>%
  summarise(
    pre_covid = mean(journeys_million[year %in% c(2018, 2019)], na.rm = TRUE),
    covid_low = mean(journeys_million[year == 2020], na.rm = TRUE),
    post_covid = mean(journeys_million[year %in% c(2024, 2025)], na.rm = TRUE),
    recovery_percent = (post_covid / pre_covid) * 100,
    .groups = "drop"
  )

# -------------------------------
# 12. Plot 2: Recovery percentage by operator
# -------------------------------
ggplot(covid_summary,
       aes(x = reorder(operator, recovery_percent),
           y = recovery_percent)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Post-COVID Recovery of Passenger Journeys by Operator",
    x = "Operator",
    y = "Recovery relative to pre-COVID levels (%)"
  ) +
  theme_minimal()

ggsave(
  "outputs/plots/figure2_recovery_percent.png",
  width = 8,
  height = 5,
  dpi = 300
)

# -------------------------------
# 13. Pre vs Post COVID comparison
# -------------------------------
covid_compare <- rail_long %>%
  filter(operator %in% top_ops,
         year %in% c(2018, 2019, 2024, 2025)) %>%
  mutate(period = ifelse(year < 2020, "Pre-COVID", "Post-COVID")) %>%
  group_by(operator, period) %>%
  summarise(
    mean_journeys = mean(journeys_million, na.rm = TRUE),
    .groups = "drop"
  )

# -------------------------------
# 14. Plot 3: Pre vs Post COVID comparison
# -------------------------------
ggplot(covid_compare,
       aes(x = reorder(operator, mean_journeys),
           y = mean_journeys,
           fill = period)) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Pre- and Post-COVID Passenger Journeys by Operator",
    x = "Operator",
    y = "Average passenger journeys (million)",
    fill = "Period"
  ) +
  theme_minimal()

ggsave(
  "outputs/plots/figure3_pre_post_covid.png",
  width = 8,
  height = 5,
  dpi = 300
)

# -------------------------------
# 15. Regression analysis (Govia Thameslink)
# -------------------------------
govia_pre <- govia_data %>% filter(year <= 2019)

lm(journeys_million ~ year, data = govia_pre)

summary(govia_pre)

############################################################
# End of script
############################################################

