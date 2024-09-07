library(curlingR)
library(tidyverse)
library(gt)

data <- load_events_stats(251)

top10 <- data %>%
  filter(n > 100) %>%
  mutate(avgOverExp = round(avg_pts - exp_pts,2)) %>%
  arrange(-avgOverExp) %>%
  head(10) %>%
  select(athlete, team, throws = n, avgOverExp)

top10 %>%
  gt()%>%
  data_color(
    columns = c(avgOverExp),
    colors = scales::col_numeric(
      palette = c("#E54343","#F5F5F5","#4395E5"),
      domain = c(0,0.4))) %>%
  cols_align(
    align = "center",
    columns = c(athlete:avgOverExp)
  )%>%
  tab_style(
    style = cell_text(weight = "bold"),
    locations = cells_body(
      columns = vars(athlete, team),
      rows = team == 'SWE (Edin)'
    )
  ) %>%
  tab_header(
    title = md("**Average Throw Score Over Expectation**"),
    subtitle = ("Top 10 Players at the 2024 World Championships"))
