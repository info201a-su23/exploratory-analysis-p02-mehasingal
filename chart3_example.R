library(ggplot2)
library(dplyr)
library(tidyr)

data <- read.csv("maryland_crash_report.csv")

filtered <- data %>%
  select(Crash.Date.Time, Driver.Substance.Abuse)

data$Crash.Date.Time <- as.Date(data$Crash.Date.Time, format = "%m/%d/%Y")

data$Year <- format(data$Crash.Date.Time, "%Y")

filtered <- data %>%
  select(Year, Driver.Substance.Abuse)

# filter data for only alcohol contributed crashes
alcohol_contributed_data <- data[data$Driver.Substance.Abuse == "ALCOHOL CONTRIBUTED", ]

# summarize the data by date to get counts
count_data <- alcohol_contributed_data %>%
  group_by(Year) %>%
  summarise(Count = n())

# creating marker dates
covid_start <- "2020"

# bar plot showcasing the trend of crashes over time with dashed markers
# representing a (rough) estimate of beginning and end of the COVID-19 pandemic
alcohol_related_accidents_overtime <- ggplot(count_data, aes(x = Year, y = Count)) +
  geom_bar(stat = "identity", fill = "blue", color = "blue") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Number of Alcohol-Related Vehicle Crashes Over Time in Maryland",
       x = "Date", y = "Number of Crashes")

print(alcohol_related_accidents_overtime)



