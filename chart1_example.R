library(ggplot2)
library(dplyr)
library(tidyr)

data <- read.csv("maryland_crash_report.csv")

filtered_data <- data %>% 
  select(Collision.Type)

collision_types <- unique(filtered_data)
collision_occurance <- table(data$Collision.Type)
collision_occurance_df <- as.data.frame(collision_occurance)
colnames(collision_occurance_df) <- c("Collision Type", "Count")

collision_type_bar_graph <- ggplot(collision_occurance_df, aes(x = `Collision Type`, y = Count)) +
  geom_bar(stat = "identity", fill = "purple") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Total Occurrence of Collision Types in Maryland from 2015-2023", x = "Collision Type", y = "Count")

print(collision_type_bar_graph)