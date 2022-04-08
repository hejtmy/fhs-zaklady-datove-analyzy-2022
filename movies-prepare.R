library(tidyverse)

source("functions/loading.R")

df_movies <- load_movies_metadata(".")
df_movies <- df_movies %>%
  filter(!is.na(vote_count)) %>%
  arrange(-vote_count) %>%
  slice_head(n = 2500)

write_csv(df_movies, "data/movies/movies_small.csv")
df_ratings <- read.csv("data/movies/ratings_small.csv", sep=",")
df_ratings <- df_ratings %>%
  left_join(select(df_movies, id, title, month, is_comedy, is_action, is_horror, vote_average, original_language),
            by=c("movieId"="id")) %>%
  filter(!is.na(title))

write_csv(df_ratings, "data/movies/movies_ratings.csv")
