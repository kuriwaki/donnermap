library(tidyverse)
library(ccesMRPprep)

raw_counts <- get_acs_cces(
  varlist = c("B01001_001",
              "C01001B_001", # black
              "C01001A_001", # white alone
              "C01001D_001", # asian
              "C01001H_001",
              "C01001I_001")) %>% # hispanic
  transmute(
    year,
    cd,
    race = recode_factor(acscode,
                  "B01001_001" = "Total",
                  "C01001H_001" = "Non-Hispanic White",
                  "C01001A_001" = "White (Including Hipanic",
                  "C01001B_001" = "Black",
                  "C01001D_001" = "Asian",
                  "C01001I_001" = "Hispanic"),
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
  transmute(
    cd,
    year,
    race,
    count,
    frac = count / count_total)


usethis::use_data(race_by_cd, overwrite = TRUE)
