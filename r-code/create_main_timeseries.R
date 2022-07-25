library(tidyverse)
library(lubridate)
library(writexl)
library(openxlsx)
library(here)
library(ggplot2)
library(scales)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(ggthemes)
library(zoo)
library(rgeos)
library(janitor)

# Import source data --------------------------------------------------------------
oxcgrtdata <- read_csv("https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/OxCGRT_latest.csv", 
                       col_types = cols(RegionName = col_character(), 
                                        RegionCode = col_character()))

oxcgrtdata <- 
  oxcgrtdata %>% 
  filter(is.na(RegionName)) %>%
  mutate(Date = ymd(Date)) %>%
  filter(Date != Sys.Date()) %>%
  group_by(CountryCode) %>%
  arrange(CountryCode, Date) %>%
  fill(ConfirmedCases, GovernmentResponseIndex, .direction = "down")


# get a time series for each index and indicator ------------------------------------- 

## extract list of indices
indices <- names(clean_names(oxcgrtdata)) %>% str_subset(pattern = "index$")
indices <- indices[indices != "stringency_legacy_index"]

## extract list of indicators 
indicators <- names(clean_names(oxcgrtdata)) %>% str_subset(pattern = "^(c|h|e)[0-9]_") %>% str_subset(pattern = "notes", negate = T)
indicators <- indicators[!indicators %in% c("h4_emergency_investment_in_healthcare", 
                             "h5_investment_in_vaccines", 
                             "e4_international_support",
                             "e3_fiscal_measures")]

## extract cases and deaths
casedeaths <- names(clean_names(oxcgrtdata)) %>% str_subset(pattern = "cases|deaths")

## create empty worksheet and write timeseries in each tab
tslist <- c(indices, indicators, casedeaths)
ts_sheet <- createWorkbook()

timeseries <- function(i){
  temp <- 
    oxcgrtdata %>% 
    clean_names() %>%
    select(all_of(i), country_code, country_name, date)
  temp <- 
    temp %>% 
    mutate(date = format(date, "%d%b%Y")) %>%
    pivot_wider(names_from = date, values_from = all_of(i))
  if(i == "c7_restrictions_on_internal_movement"){
    i <- "c7_movementrestrictions"
  } else if(i == "c8_international_travel_controls"){
    i <- "c8_internationaltravel"
  } else if(i == "e2_debt_contract_relief"){
    i <- "e2_debtrelief"
  }
  print(i)
  addWorksheet(ts_sheet, i)
  writeData(ts_sheet, i, temp)
  datevars <- str_subset(names(temp), pattern = "2020|2021")
  for(j in datevars){
    temp <- 
      temp %>%
      ungroup() %>%
      mutate(!!j := ifelse(is.na(!!sym(j)), "", !!sym(j)))
  }
  #temp <- 
  #  temp %>%
  #  mutate()
  write.csv(temp, file = paste0("./data/timeseries/", i, ".csv"))
}

lapply(tslist, timeseries)

## publish timeseries worksheet
saveWorkbook(ts_sheet, file = "./data/timeseries/OxCGRT_timeseries_all.xlsx", overwrite = T)
