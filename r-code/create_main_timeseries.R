library(tidyverse)
library(lubridate)
library(writexl)
library(openxlsx)
library(here)
library(ggplot2)
library(scales)
library(sf)
library(ggthemes)
library(zoo)
library(rgeos)
library(janitor)

# Import source data --------------------------------------------------------------
  #National Dataset:
oxcgrt_nat_data <- read_csv("https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/OxCGRT_nat_latest.csv", 
                       col_types = cols(RegionName = col_character(), 
                                        RegionCode = col_character()))
#AUS Dataset:
oxcgrt_aus_data <- read_csv("https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/Australia/OxCGRT_AUS_latest.csv", 
                            col_types = cols(RegionName = col_character(), 
                                             RegionCode = col_character()))
#CAN Dataset:
oxcgrt_can_data <- read_csv("https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/Canada/OxCGRT_CAN_latest.csv", 
                            col_types = cols(RegionName = col_character(), 
                                             RegionCode = col_character()))
#CHN Dataset:
oxcgrt_chn_data <- read_csv("https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/China/OxCGRT_CHN_latest.csv", 
                            col_types = cols(RegionName = col_character(), 
                                             RegionCode = col_character()))
#GBR Dataset:
oxcgrt_gbr_data <- read_csv("https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/United%20Kingdom/OxCGRT_GBR_latest.csv", 
                            col_types = cols(RegionName = col_character(), 
                                             RegionCode = col_character()))
#USA Dataset:
oxcgrt_usa_data <- read_csv("https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/United%20States/OxCGRT_USA_latest.csv", 
                            col_types = cols(RegionName = col_character(), 
                                             RegionCode = col_character()))

#India Dataset: TBD
#Brazil Dataset: TBD


#Remove NAT_TOTAL from Subnational data:

oxcgrt_aus_data <- 
  oxcgrt_aus_data %>% 
  filter(Jurisdiction == "STATE_TOTAL")

oxcgrt_can_data <- 
  oxcgrt_can_data %>% 
  filter(Jurisdiction == "STATE_TOTAL")

oxcgrt_chn_data <- 
  oxcgrt_chn_data %>% 
  filter(Jurisdiction == "STATE_TOTAL")

oxcgrt_gbr_data <- 
  oxcgrt_gbr_data %>% 
  filter(Jurisdiction == "STATE_TOTAL")

oxcgrt_usa_data <- 
  oxcgrt_usa_data %>% 
  filter(Jurisdiction == "STATE_TOTAL")

oxcgrtdata <- rbind(oxcgrt_nat_data, oxcgrt_aus_data, oxcgrt_can_data, oxcgrt_chn_data, oxcgrt_gbr_data, oxcgrt_usa_data)

  
oxcgrtdata <- 
  oxcgrtdata %>% 
  #filter(is.na(RegionName)) %>%
  mutate(Date = ymd(Date)) %>%
  filter(Date != Sys.Date()) %>%
  group_by(CountryCode, Jurisdiction) %>%
  arrange(CountryCode, Jurisdiction, Date) %>%
  rename(StringencyIndex_Avg=StringencyIndex_Average) %>%
  rename(ContainmentHealthIndex_Avg=ContainmentHealthIndex_Average) %>%
  rename(GovernmentResponseIndex_Avg=GovernmentResponseIndex_Average) %>%
  rename(`H8M_Protection of elderly ppl`=`H8M_Protection of elderly people`) %>%
  fill(ConfirmedCases, GovernmentResponseIndex_Avg, .direction = "down")

# get a time series for each index and indicator ------------------------------------- 

## extract list of indices
indices <- c("stringency_index_avg", "containment_health_index_avg", "government_response_index_avg", "economic_support_index")

## extract list of indicators 
indicators <- names(clean_names(oxcgrtdata)) %>% str_subset(pattern = "^(c|h|e)[0-9](m|ev|)_") %>% str_subset(pattern = "notes", negate = T)
indicators <- indicators[!indicators %in% c("h4_emergency_investment_in_healthcare", 
                                            "h5_investment_in_vaccines", 
                                            "e4_international_support",
                                            "e3_fiscal_measures",
                                            "e4_international_support")]

## extract cases and deaths
casedeaths <- names(clean_names(oxcgrtdata)) %>% str_subset(pattern = "cases|deaths")

## create empty worksheet and write timeseries in each tab
tslist <- c(indices, indicators, casedeaths)
ts_sheet <- createWorkbook()

timeseries <- function(i){
  temp <- 
    oxcgrtdata %>% 
    clean_names() %>%
    select(all_of(i), country_code, country_name, region_code, region_name, jurisdiction, date)
  temp <- 
    temp %>% 
    mutate(date = format(date, "%d%b%Y")) %>%
    pivot_wider(names_from = date, values_from = all_of(i))
  if(i == "c7m_restrictions_on_internal_movement"){
    i <- "c7m_movementrestrictions"
  } else if(i == "c8ev_international_travel_controls"){
    i <- "c8ev_internationaltravel"
  } else if(i == "e2_debt_contract_relief"){
    i <- "e2_debtrelief"
  }
  print(i)
  addWorksheet(ts_sheet, i)
  writeData(ts_sheet, i, temp)
  datevars <- str_subset(names(temp), pattern = "2020|2021|2022")
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
