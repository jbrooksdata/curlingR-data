library(curlingR)
library(tidyverse)
library(ggplot2)

data <- load_games_data(7352)

runningPoints <- data %>%
  filter(!is.na(points)) %>%
  group_by(team) %>%
  arrange(team) %>%
  mutate(attempt_number = row_number()) %>% 
  mutate(running_total = cumsum(points))

runningPoints %>%
  ggplot(aes(x = attempt_number, y = running_total, group = team, color = team)) +
  geom_line(linewidth = 1) +
  ggtitle("Running Throw Quality Score in Sweden's 8-1 Victory") +
  labs(x = "Throw Number",y = "Running Quality Score", color = "Team") +
  theme_bw()
