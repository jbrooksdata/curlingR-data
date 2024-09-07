library(curlingR)
library(tidyverse)
library(ggplot2)

# current Canadian top 5 women's teams
Top5 <- load_rankings_women() %>%
  filter(Country == 'Canada',
         # max date of 2024 season
         Date == '2024-05-20',
         # exclude Jennifer Jones
         id != 9785) %>%
  arrange(Rank) %>%
  head(5) %>%
  pull(id)

Top5History <- load_rankings_women() %>%
  filter(Season %in% c(2023,2024),
         id %in% Top5)

Top5History %>%
  ggplot(aes(x = as.Date(Date), y = Rating, group = LastName, color = LastName)) +
  geom_line(linewidth = 1) +
  ggtitle("Top 5 Canadian Team Rating Comparison, Last 2 Seasons") +
  scale_x_date(date_breaks = "3 months", date_labels = "%b %y") +
  labs(x = NULL , color = "Team") +
  theme_bw()
