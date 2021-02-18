# This loads from an external repo. Contact Shiro Kuriwaki for more

library(tidyverse)
library(Rvoteview)
library(glue)

full_cd <- read_rds("~/Dropbox/CCES_representation/data/output/averages/by-cd_info.Rds")
full_reps <-
  member_search(chamber = "House", congress = 116) %>%
  as_tibble()

rep_116 <- full_reps %>%
  transmute(icpsr,
            cd = glue("{state_abbrev}-{str_pad(district_code, width = 2, pad = '0')}"),
            ush116_rep = bioname,
            ush116_party = str_sub(party_name, 1, 1)) %>%
  group_by(cd) %>%
  arrange(desc(icpsr)) %>% # not sure which one's best
  distinct(cd, .keep_all = TRUE) %>%
  ungroup() %>%
  select(-icpsr)


cd_info <- full_cd %>%
  mutate(year = 2018) %>%
  left_join(rep_116, by = "cd") %>%
  select(year, cd,
         dailykos_name = descrip, largest_place = place,
         matches("ush"),
         pct_trump, pct_romney, pct_mccain)


usethis::use_data(cd_info, overwrite = TRUE)
