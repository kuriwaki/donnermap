

cd_race_long <- left_join(cd_st, race_by_cd) %>%
  mutate(maj_frac = replace(frac, frac < 0.5, 0),
         maj_race = replace(frac, frac < 0.5, NA_real_))

cd_race_long %>%
  filter(!is.na(maj_race),
         race != "Asian") %>%
  mutate(race = fct_relevel(race, "White", "Hispanic", "Black")) %>%
  ggplot() +
  facet_wrap(~ race) +
  geom_sf(data = st_shp, fill = "white", size = 0.1) +
  geom_sf(aes(alpha = maj_frac, fill = race),
          size = 0.5) +
  theme_map() +
  scale_alpha_continuous() +
  guides(fill = FALSE, alpha = FALSE) +
  theme(legend.position = "bottom",
        plot.title = element_text(face = "bold", hjust = 0.5)) +
  labs(title = "Majority Race",
       caption = "Source: ACS 2018. \nACS respondents who identify with multiple races are not counted towards the proportion.")


ggsave("figures/majority-race.pdf")
