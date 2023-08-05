library(ggplot2)
library(dplyr)
library(stringr)

mcrash_data <- read.csv("maryland_crash_report.csv")

summary_crashes <- list()

#Which road route in the Montgomery County has the highest reported number of collisions and what was the vehicle movement?
summary_crashes$route_crash <- mcrash_data %>% 
  group_by(Road.Name, Vehicle.Movement) %>%
  summarise(report_num = n()) %>%
  arrange(desc(report_num)) %>%
  filter(report_num == max(report_num, na.rm = TRUE))

print(summary_crashes$route_crash)


#What weather condition and road surface condition are most prominent in collision crashes?

summary_crashes$weather_crash <- mcrash_data %>% 
  group_by(Weather, Surface.Condition) %>%
  summarise(report_num = n()) %>%
  arrange(desc(report_num)) %>%
  filter(report_num == max(report_num, na.rm = TRUE))

print(summary_crashes$weather_crash)



#Which vehicle model and make has the most reported number of fatal injury collisions?

summary_crashes$model_crash <- mcrash_data %>%
  filter(Injury.Severity == "FATAL INJURY") %>%
  group_by(Vehicle.Model, Vehicle.Make) %>%
  summarise(report_num = n()) %>%
  arrange(desc(report_num)) %>%
  filter(report_num == max(report_num, na.rm = TRUE))

print(summary_crashes$model_crash)


#What are the most often types of collision during the daylight?

summary_crashes$collision_crash <- mcrash_data %>%
  filter(Light == "DAYLIGHT") %>%
  group_by(Collision.Type) %>%
  summarise(report_num = n()) %>%
  arrange(desc(report_num)) %>%
  filter(report_num == max(report_num, na.rm = TRUE))

print(summary_crashes$collision_crash)


#Which vehicle body type receive the most vehicle damage extent in crashes?

summary_crashes$dmg_crash <- mcrash_data %>%
  filter(Vehicle.Damage.Extent == "DESTROYED") %>%
  group_by(Vehicle.Body.Type) %>%
  summarise(report_num = n()) %>%
  arrange(desc(report_num)) %>%
  filter(report_num == max(report_num, na.rm = TRUE))

print(summary_crashes$dmg_crash)

