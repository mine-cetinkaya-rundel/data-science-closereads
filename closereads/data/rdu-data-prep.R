library(arrow)
library(tidyverse)
library(janitor)

# from https://community.amstat.org/dataexpo/home

# load 2023 flight data and write into a csv file

# download 2023 flights parquet file
out <- curl::curl_download(
  url = paste0("https://blobs.duckdb.org/flight-data-partitioned/", "Year=2023/data_0.parquet"), 
  destfile = here::here("closereads", "data", "flights-2023.parquet")
)

# read the parquet file
flights_2023_raw <- read_parquet(here::here("closereads", "data", "flights-2023.parquet"))

# rename all the variables into snake_case
rduflights23 <- flights_2023_raw |>
  clean_names() |>
  rename("day_of_month" = dayof_month) |>
  filter(origin == "RDU")

# write to csv
write_csv(rduflights23, here::here("closereads", "data", "rdu-flights-23.csv"))

# check that it loads
rduflights23_reload <- read_csv(here::here("closereads", "data", "rdu-flights-23.csv"))
