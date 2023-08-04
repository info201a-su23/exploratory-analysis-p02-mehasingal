library(ggplot2)
library(dplyr)
library(tidyr)

# Read the data
data <- read.csv("maryland_crash_report.cvs")

# Filter to include only the top 10 most common makes
top_makes <- data %>%
  count(Vehicle.Make) %>%
  arrange(desc(n)) %>%
  head(10) %>%
  pull(Vehicle.Make)

# Filter the data to include only the top 10 makes
filtered_data <- data %>%
  filter(Vehicle.Make %in% top_makes)

# Summarize the data by vehicle make and injury severity
summary_data <- filtered_data %>%
  group_by(Vehicle.Make, Injury.Severity) %>%
  summarise(Count = n()) %>%
  ungroup()

# Convert Injury.Severity to a factor for plotting
summary_data$Injury.Severity <- as.factor(summary_data$Injury.Severity)

# Create a jitter plot
vehicle_injury_scatterplot <- ggplot(filtered_data, aes(x = Vehicle.Make, y = Injury.Severity)) +
  geom_jitter(aes(color = Vehicle.Make), alpha = 0.4, width = 0.1) +
  labs(title = "Relationship between Vehicle Make and Injury Severity",
       x = "Top 10 Vehicle Make",
       y = "Injury Severity") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Print the scatterplot
print(vehicle_injury_scatterplot)
