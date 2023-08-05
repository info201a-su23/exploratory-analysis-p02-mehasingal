library(ggplot2)
library(dplyr)
library(knitr)


mcrash_data <- read.csv("/Users/stlp/Documents/INFO201/exploratory-analysis-p02-mehasingal/maryland_crash_report.csv")

sort1_chart <- mcrash_data %>%
  group_by(Vehicle.Make) %>%
  summarise(
    total_collisions = n(),
    fatal_injuries = sum(Injury.Severity == "FATAL INJURY"),
    driver_faults = sum(Driver.At.Fault == "Yes"),
    not_driver_faults = sum(Driver.At.Fault == "No"),
    unknown = sum(Driver.At.Fault == "Unknown")
  ) %>%
  arrange(desc(total_collisions)) %>%
  head(10)

kable(sort1_chart, col.names = c("Vehicle Make", "Total Collisions", "Fatal Injuries", "Driver Faults", "Not Driver Faults", "Unknown Fault"))

