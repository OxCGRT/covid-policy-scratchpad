library(dplyr)

country_excludes <- c("XXX", "ARM", "ASM", "ATG", "COM", "FSM", "GNB", "GNQ", "GRD", "KNA", "LCA", "MDV", "MHL", "MKD", "MNE", "NCL", "NRU", "PLW", "PRK", "PYF", "STP", "TUV", "VCT", "WSM")
indicator_includes <- c("C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "E1", "E2", "H1", "H2", "H3", "H6", "H7", "H8", "V1", "V2", "V3")


## Overall coverage

OxCGRTcoverage_nat <- read.csv(url("https://oxcgrtportal.azurewebsites.net/api/statscsv?Provisional=true&Confirmed=true&ToRecode=true&Flagged=true&FromDate=2020-01-01&ToDate=2022-12-31")) %>%
  filter(!Country %in% country_excludes) %>%
  mutate(Team = "National", .before = Country)

OxCGRTcoverage_subnat <- read.csv(url("https://oxcgrtportal.azurewebsites.net/api/statscsv?Provisional=true&Confirmed=true&ToRecode=true&Flagged=true&SubNat=true&FromDate=2020-01-01&ToDate=2022-12-31")) %>%
  filter(!(Region == "NAT_GOV" & City == "STATE_WIDE"),
         !(Country == "AUS" & City == "STATE_WIDE"),
         !(Country == "BRA" & City %in% c("STATE_WIDE", "BR_1200203", "BR_2700300", "BR_1600279", "BR_1303403", "BR_2910800", "BR_2303709", "BR_3205200", "BR_5201405", "BR_2105302", "BR_5107602", "BR_5003702", "BR_3170206", "BR_2504009", "BR_4113700", "BR_2607901", "BR_2207702", "BR_3304904", "BR_2408003", "BR_4305108", "BR_1100122", "BR_1400472", "BR_4209102", "BR_3518800", "BR_2803500", "BR_1702109", "BR_1506807", "BR_1500800")),
         !(Country == "CAN" & City == "STATE_GOV"),
         !(Country == "CHN" & Region != "NAT_GOV" & City != "STATE_WIDE"),
         !(Country == "IND" & City == "STATE_GOV"),
         !(Country == "ITA" & City == "STATE_GOV"),
         !(Country == "USA" & Region != "NAT_GOV" & City != "STATE_WIDE")) %>%
  rename(Team = Country)

OxCGRTcoverage <- full_join(OxCGRTcoverage_nat, OxCGRTcoverage_subnat) %>%
  select(Team, Country, Region, City, indicator_includes) %>%
  mutate(coverage_count = rowSums(select(., indicator_includes), na.rm = TRUE),
         missing = 20824 - coverage_count) %>%
  group_by(Team) %>%
  summarise(coverage_sum = sum(coverage_count),
            n_coverage = n(),
            complete_jurisdictions = sum(coverage_count >= 20824),
            empty_cells = sum(missing))


## Red flags

OxCGRTflags_nat <- read.csv(url("https://oxcgrtportal.azurewebsites.net/api/statscsv?Provisional=false&Confirmed=false&ToRecode=false&Flagged=true&FromDate=2020-01-01&ToDate=2022-12-31")) %>%
  filter(!Country %in% country_excludes) %>%
  mutate(Team = "National", .before = Country)

OxCGRTflags_subnat <- read.csv(url("https://oxcgrtportal.azurewebsites.net/api/statscsv?Provisional=false&Confirmed=false&ToRecode=false&Flagged=true&SubNat=true&FromDate=2020-01-01&ToDate=2022-12-31")) %>%
  filter(!(Region == "NAT_GOV" & City == "STATE_WIDE"),
         !(Country == "AUS" & City == "STATE_WIDE"),
         !(Country == "BRA" & City %in% c("STATE_WIDE", "BR_1200203", "BR_2700300", "BR_1600279", "BR_1303403", "BR_2910800", "BR_2303709", "BR_3205200", "BR_5201405", "BR_2105302", "BR_5107602", "BR_5003702", "BR_3170206", "BR_2504009", "BR_4113700", "BR_2607901", "BR_2207702", "BR_3304904", "BR_2408003", "BR_4305108", "BR_1100122", "BR_1400472", "BR_4209102", "BR_3518800", "BR_2803500", "BR_1702109", "BR_1506807", "BR_1500800")),
         !(Country == "CAN" & City == "STATE_GOV"),
         !(Country == "CHN" & Region != "NAT_GOV" & City != "STATE_WIDE"),
         !(Country == "IND" & City == "STATE_GOV"),
         !(Country == "ITA" & City == "STATE_GOV"),
         !(Country == "USA" & Region != "NAT_GOV" & City != "STATE_WIDE")) %>%
  rename(Team = Country)  

OxCGRTflags <- full_join(OxCGRTflags_nat, OxCGRTflags_subnat) %>%
  select(Team, Country, Region, City, indicator_includes) %>%
  mutate(flag_count = rowSums(select(., indicator_includes), na.rm = TRUE)) %>%
  group_by(Team) %>%
  summarise(flag_count = sum(flag_count))


## Confirmed cells

OxCGRTconfirmed_nat <- read.csv(url("https://oxcgrtportal.azurewebsites.net/api/statscsv?Provisional=false&Confirmed=true&ToRecode=false&Flagged=false&FromDate=2020-01-01&ToDate=2022-12-31")) %>%
  filter(!Country %in% country_excludes) %>%
  mutate(Team = "National", .before = Country)

OxCGRTconfirmed_subnat <- read.csv(url("https://oxcgrtportal.azurewebsites.net/api/statscsv?Provisional=false&Confirmed=true&ToRecode=false&Flagged=false&SubNat=true&FromDate=2020-01-01&ToDate=2022-12-31")) %>%
  filter(!(Region == "NAT_GOV" & City == "STATE_WIDE"),
         !(Country == "AUS" & City == "STATE_WIDE"),
         !(Country == "BRA" & City %in% c("STATE_WIDE", "BR_1200203", "BR_2700300", "BR_1600279", "BR_1303403", "BR_2910800", "BR_2303709", "BR_3205200", "BR_5201405", "BR_2105302", "BR_5107602", "BR_5003702", "BR_3170206", "BR_2504009", "BR_4113700", "BR_2607901", "BR_2207702", "BR_3304904", "BR_2408003", "BR_4305108", "BR_1100122", "BR_1400472", "BR_4209102", "BR_3518800", "BR_2803500", "BR_1702109", "BR_1506807", "BR_1500800")),
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
            pct_confirmed = (confirmed*100) / (n_confirmed*20824),
            jurisdictions_over_50 = sum(confirmed_count >= (20824/2)))


## FULL REPORT

report <- full_join(OxCGRTcoverage, full_join(OxCGRTflags, OxCGRTconfirmed, by = c("Team")), by = c("Team")) %>%
  select(Team, complete_jurisdictions, n_coverage, empty_cells, flag_count, jurisdictions_over_50, pct_confirmed) %>%
  mutate(complete_jurisdictions = paste(as.character(complete_jurisdictions), as.character(n_coverage), sep = "/"),
         jurisdictions_over_50 = paste(as.character(jurisdictions_over_50), as.character(n_coverage), sep = "/")) %>%
  select(!n_coverage)

write.csv(report, "overall_stats.csv")
