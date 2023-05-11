library(dplyr)
library(readr)

country_excludes <- c("XXX", "ARM", "ASM", "ATG", "COM", "FSM", "GNB", "GNQ", "GRD", "KNA", "LCA", "MDV", "MHL", "MKD", "MNE", "NCL", "NRU", "PLW", "PRK", "PYF", "STP", "TUV", "VCT", "WSM")
indicator_includes <- c("C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "E1", "E2", "H1", "H2", "H3", "H6", "H7", "H8", "V1", "V2", "V3", "V4")
indicator_includes_noV4 <- c("C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "E1", "E2", "H1", "H2", "H3", "H6", "H7", "H8", "V1", "V2", "V3")
italy_indicator <- c("C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "H1", "H2", "H3", "H6", "H7", "H8")

## Overall coverage

OxCGRTcoverage_nat <- read.csv(url("https://oxcgrtportal.azurewebsites.net/api/statscsv?Provisional=true&Confirmed=true&ToRecode=true&Flagged=true&FromDate=2020-01-01&ToDate=2022-12-31")) %>%
  filter(!Country %in% country_excludes) %>%
  mutate(Team = "National", .before = Country)

OxCGRTcoverage_subnat <- read.csv(url("https://oxcgrtportal.azurewebsites.net/api/statscsv?Provisional=true&Confirmed=true&ToRecode=true&Flagged=true&SubNat=true&FromDate=2020-01-01&ToDate=2022-12-31")) %>%
  filter(!(Region == "NAT_GOV" & City == "STATE_WIDE"),
         !(Country == "AUS" & City == "STATE_WIDE"),
         !(Country == "BRA" & City == "STATE_WIDE"),
         !(Country == "CAN" & City == "STATE_GOV"),
         !(Country == "CHN"),
         !(Country == "IND" & City == "STATE_GOV"),
         !(Country == "ITA"),
         !(Country == "USA" & Region != "NAT_GOV" & City != "STATE_WIDE")) %>%
  rename(Team = Country)

OxCGRTcoverage_China <- read.csv(url("https://oxcgrtportal.azurewebsites.net/api/statscsv?Provisional=true&Confirmed=true&ToRecode=true&Flagged=true&SubNat=true&FromDate=2020-01-01&ToDate=2023-02-28")) %>%
  filter((Country == "CHN"),
         !(Region == "NAT_GOV" & City == "STATE_WIDE"),
         !(Country == "CHN" & Region != "NAT_GOV" & City != "STATE_WIDE"),
         !(Region == "NAT_TOTAL")) %>%
  rename(Team = Country) %>%
  select(Team, Region, City, all_of(indicator_includes_noV4)) %>%
  mutate(coverage_count = rowSums(select(., indicator_includes_noV4), na.rm = TRUE),
         missing = 21945 - coverage_count) %>%
  group_by(Team) %>%
  summarise(coverage_sum = sum(coverage_count),
            n_coverage = n(),
            complete_jurisdictions = sum(coverage_count >= 21945),
            empty_cells = sum(missing)) %>%
  mutate(empty_cells = ifelse(empty_cells < 0, 0, empty_cells))

OxCGRTcoverage_Italy <- read.csv(url("https://oxcgrtportal.azurewebsites.net/api/statscsv?Provisional=true&Confirmed=true&ToRecode=true&Flagged=true&SubNat=true&FromDate=2020-01-01&ToDate=2021-12-31")) %>%
  filter(!(Region == "NAT_GOV" & City == "STATE_WIDE"),
         Country == "ITA",
         !(City == "STATE_GOV")) %>%
  rename(Team = Country) %>%
  select(Team, Region, City, all_of(italy_indicator)) %>%
  mutate(coverage_count = rowSums(select(., italy_indicator), na.rm = TRUE),
         missing = 10234 - coverage_count) %>%
  group_by(Team) %>%
  summarise(coverage_sum = sum(coverage_count),
            n_coverage = n(),
            complete_jurisdictions = sum(coverage_count >= 10234),
            empty_cells = sum(missing)) %>%
  mutate(empty_cells = ifelse(empty_cells < 0, 0, empty_cells))

OxCGRTcoverage <- full_join(OxCGRTcoverage_nat, OxCGRTcoverage_subnat) %>%
  select(Team, Country, Region, City, all_of(indicator_includes_noV4)) %>%
  mutate(coverage_count = rowSums(select(., indicator_includes_noV4), na.rm = TRUE),
         missing = 20824 - coverage_count) %>%
  group_by(Team) %>%
  summarise(coverage_sum = sum(coverage_count),
            n_coverage = n(),
            complete_jurisdictions = sum(coverage_count >= 20824),
            empty_cells = sum(missing)) %>%
  mutate(empty_cells = ifelse(empty_cells < 0, 0, empty_cells)) %>%
  full_join(OxCGRTcoverage_Italy) %>%
  full_join(OxCGRTcoverage_China) %>%
  add_row(Team = "EVERYTHING",
          coverage_sum = sum(.$coverage_sum),
          n_coverage = sum(.$n_coverage),
          complete_jurisdictions = sum(.$complete_jurisdictions),
          empty_cells = sum(.$empty_cells))


## Red flags

OxCGRTflags_nat <- read.csv(url("https://oxcgrtportal.azurewebsites.net/api/statscsv?Provisional=false&Confirmed=false&ToRecode=false&Flagged=true&FromDate=2020-01-01&ToDate=2022-12-31")) %>%
  filter(!Country %in% country_excludes) %>%
  mutate(Team = "National", .before = Country)

OxCGRTflags_subnat <- read.csv(url("https://oxcgrtportal.azurewebsites.net/api/statscsv?Provisional=false&Confirmed=false&ToRecode=false&Flagged=true&SubNat=true&FromDate=2020-01-01&ToDate=2022-12-31")) %>%
  filter(!(Region == "NAT_GOV" & City == "STATE_WIDE"),
         !(Country == "AUS" & City == "STATE_WIDE"),
         !(Country == "BRA" & City == "STATE_WIDE"),
         !(Country == "CAN" & City == "STATE_GOV"),
         !(Country == "CHN" & Region != "NAT_GOV" & City != "STATE_WIDE"),
         !(Country == "IND" & City == "STATE_GOV"),
         !(Country == "ITA" & City == "STATE_GOV"),
         !(Country == "USA" & Region != "NAT_GOV" & City != "STATE_WIDE")) %>%
  rename(Team = Country)

OxCGRTflags <- full_join(OxCGRTflags_nat, OxCGRTflags_subnat) %>%
  select(Team, Country, Region, City, all_of(indicator_includes)) %>%
  mutate(flag_count = rowSums(select(., all_of(indicator_includes)), na.rm = TRUE)) %>%
  group_by(Team) %>%
  summarise(flag_count = sum(flag_count)) %>%
  add_row(Team = "EVERYTHING",
          flag_count = sum(.$flag_count))


## Confirmed cells

OxCGRTconfirmed_nat <- read.csv(url("https://oxcgrtportal.azurewebsites.net/api/statscsv?Provisional=false&Confirmed=true&ToRecode=false&Flagged=false&FromDate=2020-01-01&ToDate=2022-12-31")) %>%
  filter(!Country %in% country_excludes) %>%
  mutate(Team = "National", .before = Country)

OxCGRTconfirmed_subnat <- read.csv(url("https://oxcgrtportal.azurewebsites.net/api/statscsv?Provisional=false&Confirmed=true&ToRecode=false&Flagged=false&SubNat=true&FromDate=2020-01-01&ToDate=2022-12-31")) %>%
  filter(!(Region == "NAT_GOV" & City == "STATE_WIDE"),
         !(Country == "AUS" & City == "STATE_WIDE"),
         !(Country == "BRA" & City == "STATE_WIDE"),
         !(Country == "CAN" & City == "STATE_GOV"),
         !(Country == "CHN" & Region != "NAT_GOV" & City != "STATE_WIDE"),
         !(Country == "IND" & City == "STATE_GOV"),
         !(Country == "ITA" & City == "STATE_GOV"),
         !(Country == "USA" & Region != "NAT_GOV" & City != "STATE_WIDE")) %>%
  rename(Team = Country)

OxCGRTconfirmed <- full_join(OxCGRTconfirmed_nat, OxCGRTconfirmed_subnat) %>%
  select(Team, Country, Region, City, indicator_includes) %>%
  mutate(confirmed_count = rowSums(select(., indicator_includes), na.rm = TRUE)) %>%
  group_by(Team) %>%
  summarise(confirmed = sum(confirmed_count),
            n_confirmed = n(),
            jurisdictions_over_50_pct_confirmed = sum(confirmed_count >= (21920/2))) %>%
  add_row(Team = "EVERYTHING",
          confirmed = sum(.$confirmed),
          n_confirmed = sum(.$n_confirmed),
          jurisdictions_over_50_pct_confirmed = sum(.$jurisdictions_over_50_pct_confirmed)) %>%
  mutate(pct_confirmed = round((confirmed*100) / (n_confirmed*21920), 2))


## Reviewed cells

last_change_nat <- read_csv("https://oxcgrtportal.azurewebsites.net/api/csvdownload?type=data_status_last_change") %>%
  filter(!CountryCode %in% country_excludes) %>%
  filter(Date <= 20221231) %>%
  mutate(Team = "National", .before = CountryName)

last_change_subnat <- read_csv("https://oxcgrtportal.azurewebsites.net/api/csvdownload?type=data_status_last_change_subnat") %>%
  filter(!(Jurisdiction == "NAT_GOV" & CityCode == "STATE_WIDE"),
         !(CountryCode == "AUS" & Jurisdiction == "STATE_WIDE"),
         !(Country == "BRA" & City == "STATE_WIDE"),
         !(CountryCode == "CAN" & Jurisdiction == "STATE_GOV"),
         !(CountryCode == "CHN"),
         !(CountryCode == "IND" & Jurisdiction == "STATE_GOV"),
         !(CountryCode == "ITA" & Jurisdiction == "STATE_GOV"),
         !(CountryCode == "USA" & Jurisdiction != "NAT_GOV" & Jurisdiction != "STATE_WIDE")) %>%
  filter(Date <= 20221231) %>%
  rename(Team = CountryCode)

last_change_subnat_china <- read_csv("https://oxcgrtportal.azurewebsites.net/api/csvdownload?type=data_status_last_change_subnat") %>%
  filter(!(Jurisdiction == "NAT_GOV" & CityCode == "STATE_WIDE"),
         (CountryCode == "CHN"),
         !(CountryCode == "CHN" & Jurisdiction != "NAT_GOV" & Jurisdiction != "STATE_WIDE")) %>%
  filter(Date <= 20230228) %>%
  rename(Team = CountryCode)


OxCGRT_last_change <- full_join(last_change_nat, last_change_subnat) %>%
  full_join(last_change_subnat_china) %>%
  mutate(C1_check = (C1_RawStatus == 2 | C1_PreviousCount > 0),
         C2_check = (C2_RawStatus == 2 | C2_PreviousCount > 0),
         C3_check = (C3_RawStatus == 2 | C3_PreviousCount > 0),
         C4_check = (C4_RawStatus == 2 | C4_PreviousCount > 0),
         C5_check = (C5_RawStatus == 2 | C5_PreviousCount > 0),
         C6_check = (C6_RawStatus == 2 | C6_PreviousCount > 0),
         C7_check = (C7_RawStatus == 2 | C7_PreviousCount > 0),
         C8_check = (C8_RawStatus == 2 | C8_PreviousCount > 0),
         E1_check = (E1_RawStatus == 2 | E1_PreviousCount > 0),
         E2_check = (E2_RawStatus == 2 | E2_PreviousCount > 0),
         H1_check = (H1_RawStatus == 2 | H1_PreviousCount > 0),
         H2_check = (H2_RawStatus == 2 | H2_PreviousCount > 0),
         H3_check = (H3_RawStatus == 2 | H3_PreviousCount > 0),
         H6_check = (H6_RawStatus == 2 | H6_PreviousCount > 0),
         H7_check = (H7_RawStatus == 2 | H7_PreviousCount > 0),
         H8_check = (H8_RawStatus == 2 | H8_PreviousCount > 0),
         V1_check = (V1_RawStatus == 2 | V1_PreviousCount > 0),
         V2_check = (V2_RawStatus == 2 | V2_PreviousCount > 0),
         V3_check = (V3_RawStatus == 2 | V3_PreviousCount > 0)) %>%
  select(Team, CountryCode, RegionCode, CityCode, Jurisdiction, Date,
         C1_check, C2_check, C3_check, C4_check, C5_check, C6_check, C7_check, C8_check, 
         E1_check, E2_check,
         H1_check, H2_check, H3_check, H6_check, H7_check, H8_check,
         V1_check, V2_check, V3_check) 

OxCGRT_last_change <- OxCGRT_last_change %>%
  mutate(reviewed = rowSums(OxCGRT_last_change[, c(7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25)], na.rm = TRUE)) %>%
  select(Team, CountryCode, RegionCode, CityCode, Jurisdiction, Date, reviewed) %>%
  group_by(Team, CountryCode, RegionCode, CityCode, Jurisdiction) %>%
  summarise(reviewed = sum(reviewed),
            total = n()) %>%
  ungroup() %>%
  group_by(Team) %>%
  summarise(jurisdictions_over_80_pct_reviewed = sum(reviewed >= total*19*0.8),
            reviewed = sum(reviewed),
            n_reviewed = n(),
            total = sum(total)) %>%
  add_row(Team = "EVERYTHING",
          reviewed = sum(.$reviewed),
          n_reviewed = sum(.$n_reviewed),
          jurisdictions_over_80_pct_reviewed = sum(.$jurisdictions_over_80_pct_reviewed),
          total = sum(.$total)) %>%
  mutate(pct_reviewed = round((reviewed*100) / (total*19), 2))

# summarise(pct_reviewed = round(((100*sum(reviewed)) / (19*sum(total))), 2),
#          jurisdictions_over_80_pct_reviewed = paste(as.character(sum(reviewed >= total*19*0.8)), as.character(n()), sep = "/"))


## FULL REPORT

report <- full_join(OxCGRTcoverage, full_join(OxCGRTflags, full_join(OxCGRTconfirmed, OxCGRT_last_change, by = c("Team")), by = c("Team")), by = c("Team")) %>%
  select(Team, complete_jurisdictions, n_coverage, empty_cells, flag_count, jurisdictions_over_80_pct_reviewed, pct_reviewed, jurisdictions_over_50_pct_confirmed, pct_confirmed) %>%
  mutate(complete_jurisdictions = paste(as.character(complete_jurisdictions), as.character(n_coverage), sep = "/"),
         jurisdictions_over_50_pct_confirmed = paste(as.character(jurisdictions_over_50_pct_confirmed), as.character(n_coverage), sep = "/"),
         jurisdictions_over_80_pct_reviewed = paste(as.character(jurisdictions_over_80_pct_reviewed), as.character(n_coverage), sep = "/")) %>%
  select(!n_coverage)


write.csv(report, "overall_stats.csv")
