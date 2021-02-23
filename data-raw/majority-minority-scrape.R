library(tidyverse)
library(ccesMRPprep)

raw_counts <- get_acs_cces(
  varlist = c("B01001_001",
              "B01001H_001", # black
              "B01001B_001",
              "B01001I_001", # asian
              "B01001D_001",
              "B01001C_001"),
  dataset = "acs5",
  year = 2018) %>%
  transmute(
    year,
    cd,
    race = recode_factor(acscode,
                  "B01001_001" = "Total",
                  "B01001H_001" = "Non-Hispanic White",
                  "B01001B_001" = "Black",
                  "B01001I_001" = "Hispanic",
                  "B01001D_001" = "Asian",
                  "B01001C_001" = "American Indian"),
    count,
    count_moe
  )

tot_counts <- filter(raw_counts, race == "Total") %>%
  transmute(cd, count_total = count)


race_by_cd <-
  left_join(
    filter(raw_counts, race != "Total"),
    tot_counts,
    by = "cd") %>%
  mutate(count = na_if(count, 0)) %>%
  transmute(
    cd,
    year,
    race,
    count,
    frac = count / count_total)


usethis::use_data(race_by_cd, overwrite = TRUE)
