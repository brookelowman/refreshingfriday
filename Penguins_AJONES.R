library(palmerpenguins)
library(tidyverse)
library(wesanderson)

penguins_clean <- penguins %>% filter(!is.na(bill_length_mm), !is.na(sex))

all <- penguins_clean %>%
  ggplot() +
  geom_point(aes(bill_depth_mm,bill_length_mm),size = 2, alpha = 0.7) +
  stat_smooth(aes(bill_depth_mm,bill_length_mm),method='glm',fill=NA,colour='black') +
  labs(title = "Correlation in bill dimensions v1",
       subtitle = "For all species",
       x='Bill depth (mm)',
       y='Bill length (mm)')

species <- penguins_clean %>%
  ggplot() +
  geom_point(aes(bill_depth_mm,bill_length_mm, color = species, shape = species),size = 2, alpha = 0.7) +
  stat_smooth(aes(bill_depth_mm,bill_length_mm, color = species),method='glm',fill=NA) +
  labs(title = "Correlation in bill dimensions v2",
       subtitle = "For each species",
       x='Bill depth (mm)',
       y='Bill length (mm)',
       color='Species',
       shape='Species') +
  scale_colour_manual(values = wes_palette("Darjeeling1"))

sex <- penguins_clean %>%
  ggplot() +
  geom_point(aes(bill_depth_mm,bill_length_mm, color = sex, shape = sex),size = 2, alpha = 0.7) +
  stat_smooth(aes(bill_depth_mm,bill_length_mm, color = sex, shape = sex),method='glm',fill=NA) +
  labs(title = "Correlation in bill dimensions v3",
       subtitle = "For each species and sex",
       x='Bill depth (mm)',
       y='Bill length (mm)',
       color='Sex',
       shape='Sex')  +
  facet_wrap(~species)

library(patchwork)

(all + species) / sex