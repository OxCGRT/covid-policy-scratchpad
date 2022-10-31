# Import data
OxCGRTData <- read.csv(url("https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker-legacy/main/legacy_data_202207/OxCGRT_latest.csv"))

# Change date format
OxCGRTData$Date<- as.Date(as.character(OxCGRTData$Date),format = "%Y%m%d")

# Create an identifier for national-level policies
OxCGRTData$RegionName[OxCGRTData$RegionName==""] <- "National Government" 

# Last day of coding for each indicator
library(dplyr)

c1 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na(C1_School.closing)) %>% 
  summarise(C1 = max(Date))

c2 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na(C2_Workplace.closing)) %>% 
  summarise(C2 = max(Date))

c3 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na(C3_Cancel.public.events)) %>% 
  summarise(C3 = max(Date))

c4 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na(C4_Restrictions.on.gatherings)) %>% 
  summarise(C4 = max(Date))

c5 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na(C5_Close.public.transport!="NA")) %>% 
  summarise(C5 = max(Date))


c6 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na(C6_Stay.at.home.requirements!="NA")) %>% 
  summarise(C6 = max(Date))

c7 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na(C7_Restrictions.on.internal.movement!="NA")) %>% 
  summarise(C7 = max(Date))

c8 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na(C8_International.travel.controls!="NA")) %>% 
  summarise(C8 = max(Date))

e1 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na(E1_Income.support!="NA")) %>% 
  summarise(E1 = max(Date))

e2 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na(E2_Debt.contract.relief!="NA")) %>% 
  summarise(E2 = max(Date))

e3 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na(E3_Fiscal.measures!="NA")) %>% 
  summarise(E3 = max(Date))

e4 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na(E4_International.support!="NA")) %>% 
  summarise(E4 = max(Date))

h1 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na(H1_Public.information.campaigns!="NA")) %>% 
  summarise(H1 = max(Date))

h2 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na(H2_Testing.policy!="NA")) %>% 
  summarise(H2 = max(Date))

h3 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na((H3_Contact.tracing!="NA")!="NA")) %>% 
  summarise(H3 = max(Date))

h4 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na((H4_Emergency.investment.in.healthcare!="NA")!="NA")) %>% 
  summarise(H4 = max(Date))

h5 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na((H5_Investment.in.vaccines!="NA")!="NA")) %>% 
  summarise(H5 = max(Date))

h6 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na((H6_Facial.Coverings!="NA")!="NA")) %>% 
  summarise(H6 = max(Date))

h7 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na((H7_Vaccination.policy!="NA")!="NA")) %>% 
  summarise(H7 = max(Date))

h8 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na((H8_Protection.of.elderly.people!="NA")!="NA")) %>% 
  summarise(H8 = max(Date))

v1 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na((V1_Vaccine.Prioritisation..summary.!="NA")!="NA")) %>% 
  summarise(V1 = max(Date))

v2 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na((V2A_Vaccine.Availability..summary.!="NA")!="NA")) %>% 
  summarise(V2 = max(Date))

v3 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na((V3_Vaccine.Financial.Support..summary.!="NA")!="NA")) %>% 
  summarise(V3 = max(Date))

v4 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  filter(!is.na((V4_Mandatory.Vaccination..summary.!="NA")!="NA")) %>% 
  summarise(V4 = max(Date))

# Flagged data points (national-level policies)
date <- Sys.Date()
first_date <- as.Date(c("2020-01-01"))
diff_in_days<- difftime(date ,first_date , units = c("days"))

file_path_nat <- paste0("https://oxcgrtportal.azurewebsites.net/api/statscsv?Provisional=false&Confirmed=false&ToRecode=false&Flagged=true&Nat=true&FromDate=2020-01-01&ToDate=", date)
flagNat <- read.csv(file_path_nat, header = TRUE, sep = ",")
flagNat$flagcount <-rowSums(flagNat[c(2:11, 14:16, 19:21, 23:26)], na.rm = TRUE)
#it now includes V1-V4 (Bernardo)
flagNat$total_days <- diff_in_days*20
flagNat$total_days <- as.numeric(flagNat$total_days)
flagNat$pctg_flagged <- (flagNat$flagcount/flagNat$total_days)*100

flagNat <- select(flagNat, c(1,27, 29))
names(flagNat) = c("CountryCode", "Flagged data", "% of Flagged data")

# Flagged data points (subnational policies)
file_path_subnat <- paste0("https://oxcgrtportal.azurewebsites.net/api/statscsv?Provisional=false&Confirmed=false&ToRecode=false&Flagged=true&SubNat=true&FromDate=2020-01-01&ToDate=", date)
flagSubNat <- read.csv(file_path_subnat, header = TRUE, sep = ",")
flagSubNat$flagcount <-rowSums(flagSubNat[c(4:13, 16:18, 21:23, 25:28)], na.rm = TRUE)
#it now includes V1-V4 (Bernardo)
flagSubNat <- subset(flagSubNat, Country %in% c("BRA", "CAN", "CHN", "GBR", "USA", "AUS", "IND"))
flagSubNat <- select(flagSubNat, c(2,29))
names(flagSubNat) = c("RegionCode", "Flagged_data")
flagSubNat <- flagSubNat%>%group_by(RegionCode)%>%summarise_all(funs(mean))

flagSubNat$total_days <- diff_in_days*20
flagSubNat$total_days <- as.numeric(flagSubNat$total_days)
flagSubNat$pctg_flagged <- (flagSubNat$Flagged_data/flagSubNat$total_days)*100
flagSubNat <- select(flagSubNat, c(1,2,4))
names(flagSubNat) = c("RegionCode", "Flagged data", "% of Flagged data")

#Confirmed data points (national) --> Bernardo
file_path_conf_nat <- paste0("https://oxcgrtportal.azurewebsites.net/api/statscsv?Provisional=false&Confirmed=true&ToRecode=false&Flagged=false&Nat=true&FromDate=2020-01-01&ToDate=", date)
confNat <- read.csv(file_path_conf_nat, header = TRUE, sep = ",")
confNat$confcount <-rowSums(confNat[c(2:11, 14:16, 19:21, 23:26)], na.rm = TRUE)
confNat$total_days <- diff_in_days*20
confNat$total_days <- as.numeric(confNat$total_days)
confNat$pctg_confirmed <- (confNat$confcount/confNat$total_days)*100

confNat <- select(confNat, c(1,27, 29))
names(confNat) = c("CountryCode", "Confirmed data", "% of Confirmed data")


# Confirmed data points (subnational policies) --> Bernardo
file_path_conf_subnat <- paste0("https://oxcgrtportal.azurewebsites.net/api/statscsv?Provisional=false&Confirmed=true&ToRecode=false&Flagged=false&SubNat=true&FromDate=2020-01-01&ToDate=", date)
confSubNat <- read.csv(file_path_conf_subnat, header = TRUE, sep = ",")
confSubNat$flagcount <-rowSums(confSubNat[c(4:13, 16:18, 21:23, 25:28)], na.rm = TRUE)
#it now includes V1-V4 (Bernardo)
confSubNat <- subset(confSubNat, Country %in% c("BRA", "CAN", "CHN", "GBR", "USA", "AUS", "IND"))
confSubNat <- select(confSubNat, c(2,29))
names(confSubNat) = c("RegionCode", "Confirmed_data")
confSubNat <- confSubNat%>%group_by(RegionCode)%>%summarise_all(funs(mean))

confSubNat$total_days <- diff_in_days*20
confSubNat$total_days <- as.numeric(confSubNat$total_days)
confSubNat$pctg_confirmed <- (confSubNat$Confirmed_data/confSubNat$total_days)*100
confSubNat <- select(confSubNat, c(1,2,4))
names(confSubNat) = c("RegionCode", "Confirmed data", "% of Confirmed data")

# Merge the dataframes into one
OxCGRT_Coding_LastDate <- merge(c1,c2, by=c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(c1, c2, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c3, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c4, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c5, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c6, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c7, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c8, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, e1, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, e2, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, e3, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, e4, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h1, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h2, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h3, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h4, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h5, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h6, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h7, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h8, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, v1, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, v2, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, v3, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, v4, by = c("CountryName","RegionName", "CountryCode", "RegionCode"), all=TRUE)

# Label variables
names(OxCGRT_Coding_LastDate) = c("CountryName", "Jurisdiction", "CountryCode", "RegionCode", "C1: School closing", "C2: Workplace closing",
                                  "C3: Cancel public events", "C4: Restrictions on gatherings",
                                  "C5: Close public transport", "C6: Stay at home requirements",
                                  "C7: Restrictions on internal movement", "C8: International travel controls",
                                  "E1: Income support", "E2: Debt/contract relief", "E3: Fiscal measures",
                                  "E4: International support", "H1: Public information campaigns", "H2: Testing policy",
                                  "H3: Contact tracing", "H4: Emergency investment in healthcare",
                                  "H5: Investment in vaccines", "H6: Facial Coverings", "H7: Vaccination policy",
                                  "H8: Protection of elderly people", "V1: Vaccine prioritisation", "V2: Vaccine availability",
                                  "V3: Vaccine financial support", "V4: Mandatory vaccination")

# Identify how many days are out of date for each indicator:
OxCGRT_Coding_LastDate$current_date <- Sys.Date()


OxCGRT_Coding_LastDate$outdate_days_all <-((OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C1: School closing`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C2: Workplace closing`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C3: Cancel public events`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C4: Restrictions on gatherings`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C5: Close public transport`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C6: Stay at home requirements`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C7: Restrictions on internal movement`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C8: International travel controls`) +
                                             
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`E1: Income support`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`E2: Debt/contract relief`) +
                                             
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`H1: Public information campaigns`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`H2: Testing policy`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`H3: Contact tracing`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`H6: Facial Coverings`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`H7: Vaccination policy`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`H8: Protection of elderly people`) +
                                             
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`V1: Vaccine prioritisation`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`V2: Vaccine availability`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`V3: Vaccine financial support`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`V4: Mandatory vaccination`)) / 20


OxCGRT_Coding_LastDate$outdate_days_c_e_h <-((OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C1: School closing`) +
                                               (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C2: Workplace closing`) +
                                               (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C3: Cancel public events`) +
                                               (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C4: Restrictions on gatherings`) +
                                               (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C5: Close public transport`) +
                                               (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C6: Stay at home requirements`) +
                                               (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C7: Restrictions on internal movement`) +
                                               (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C8: International travel controls`) +
                                               
                                               (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`E1: Income support`) +
                                               (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`E2: Debt/contract relief`) +
                                               
                                               (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`H1: Public information campaigns`) +
                                               (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`H2: Testing policy`) +
                                               (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`H3: Contact tracing`) +
                                               (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`H6: Facial Coverings`) +
                                               (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`H7: Vaccination policy`) +
                                               (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`H8: Protection of elderly people`)) / 16

OxCGRT_Coding_LastDate$outdate_days_c_h <-((OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C1: School closing`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C2: Workplace closing`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C3: Cancel public events`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C4: Restrictions on gatherings`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C5: Close public transport`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C6: Stay at home requirements`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C7: Restrictions on internal movement`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`C8: International travel controls`) +
                                             
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`H1: Public information campaigns`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`H2: Testing policy`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`H3: Contact tracing`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`H6: Facial Coverings`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`H7: Vaccination policy`) +
                                             (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`H8: Protection of elderly people`)) / 14


# Identify how many days are missing for each indicator.
c1_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(c1 = sum(count = is.na(C1_School.closing)))

c2_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(c2 = sum(count = is.na(C2_Workplace.closing)))

c3_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(c3 = sum(count = is.na(C3_Cancel.public.events)))

c4_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(c4 = sum(count = is.na(C4_Restrictions.on.gatherings)))

c5_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(c5 = sum(count = is.na(C5_Close.public.transport)))

c6_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(c6 = sum(count = is.na(C6_Stay.at.home.requirements)))

c7_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(c7 = sum(count = is.na(C7_Restrictions.on.internal.movement)))

c8_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(c8 = sum(count = is.na(C8_International.travel.controls)))

e1_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(e1 = sum(count = is.na(E1_Income.support)))

e2_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(e2 = sum(count = is.na(E2_Debt.contract.relief)))

h1_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(h1 = sum(count = is.na(H1_Public.information.campaigns)))

h2_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(h2 = sum(count = is.na(H2_Testing.policy)))

h3_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(h3 = sum(count = is.na(H3_Contact.tracing)))

h6_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(h6 = sum(count = is.na(H6_Facial.Coverings)))

h7_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(h7 = sum(count = is.na(H7_Vaccination.policy)))

h8_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(h8 = sum(count = is.na(H8_Protection.of.elderly.people)))

v1_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(v1 = sum(count = is.na(V1_Vaccine.Prioritisation..summary.)))

v2_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(v2 = sum(count = is.na(V2A_Vaccine.Availability..summary.)))

v3_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(v3 = sum(count = is.na(V3_Vaccine.Financial.Support..summary.)))

v4_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(v4 = sum(count = is.na(V4_Mandatory.Vaccination..summary.)))


OxCGRT_missing <- merge(c1_missing, c2_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, c3_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, c4_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, c5_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, c6_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, c7_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, c8_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, e1_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, e2_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, h1_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, h2_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, h3_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, h6_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, h7_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, h8_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, v1_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, v2_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, v3_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, v4_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))

OxCGRT_missing$missing_days_all <- ((OxCGRT_missing[,5]) + (OxCGRT_missing[,6]) + (OxCGRT_missing[,7]) + 
                                      (OxCGRT_missing[,8]) + (OxCGRT_missing[,9]) + (OxCGRT_missing[,10]) + 
                                      (OxCGRT_missing[,11]) + (OxCGRT_missing[,12]) + (OxCGRT_missing[,13]) + 
                                      (OxCGRT_missing[,14]) + (OxCGRT_missing[,15]) + (OxCGRT_missing[,16]) + 
                                      (OxCGRT_missing[,17]) + (OxCGRT_missing[,18]) + (OxCGRT_missing[,19]) + 
                                      (OxCGRT_missing[,20]) + (OxCGRT_missing[,21]) + (OxCGRT_missing[,22]) + 
                                      (OxCGRT_missing[,23]) + (OxCGRT_missing[,24])) / 20

OxCGRT_missing$missing_days_c_e_h <- ((OxCGRT_missing[,5]) + (OxCGRT_missing[,6]) + (OxCGRT_missing[,7]) + 
                                        (OxCGRT_missing[,8]) + (OxCGRT_missing[,9]) + (OxCGRT_missing[,10]) + 
                                        (OxCGRT_missing[,11]) + (OxCGRT_missing[,12]) + (OxCGRT_missing[,13]) + 
                                        (OxCGRT_missing[,14]) + (OxCGRT_missing[,15]) + (OxCGRT_missing[,16]) + 
                                        (OxCGRT_missing[,17]) + (OxCGRT_missing[,18]) + (OxCGRT_missing[,19]) + 
                                        (OxCGRT_missing[,20])) / 16  

OxCGRT_missing$missing_days_c_h <- ((OxCGRT_missing[,5]) + (OxCGRT_missing[,6]) + (OxCGRT_missing[,7]) + 
                                      (OxCGRT_missing[,8]) + (OxCGRT_missing[,9]) + (OxCGRT_missing[,10]) + 
                                      (OxCGRT_missing[,11]) + (OxCGRT_missing[,12]) + (OxCGRT_missing[,15]) + 
                                      (OxCGRT_missing[,16]) + (OxCGRT_missing[,17]) + (OxCGRT_missing[,18]) + 
                                      (OxCGRT_missing[,19]) +  (OxCGRT_missing[,20])) / 14  

OxCGRT_missing <- select(OxCGRT_missing, c(1, 4, 25, 26, 27))
#OxCGRT_missing <- subset(OxCGRT_missing, OxCGRT_missing$RegionName != "Distrito Federal")

OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, OxCGRT_missing, by = c("CountryName", "RegionCode"), all=TRUE)



# Label variables
names(OxCGRT_Coding_LastDate) = c("CountryName", "RegionCode", "Jurisdiction", "CountryCode", "C1: School closing", "C2: Workplace closing",
                                  "C3: Cancel public events", "C4: Restrictions on gatherings",
                                  "C5: Close public transport", "C6: Stay at home requirements",
                                  "C7: Restrictions on internal movement", "C8: International travel controls",
                                  "E1: Income support", "E2: Debt/contract relief", "E3: Fiscal measures",
                                  "E4: International support", "H1: Public information campaigns", "H2: Testing policy",
                                  "H3: Contact tracing", "H4: Emergency investment in healthcare",
                                  "H5: Investment in vaccines", "H6: Facial Coverings", "H7: Vaccination policy",
                                  "H8: Protection of elderly people", "V1: Vaccine prioritisation", "V2: Vaccine availability",
                                  "V3: Vaccine financial support", "V4: Mandatory vaccination", "Current date", "Outdated coding in days ALL (avg.)",
                                  "Outdated coding in days C, E, H (avg.)", "Outdated coding in days C, H (avg.)", "Missing days ALL (avg.)",
                                  "Missing days C, E, H (avg.)", "Missing days C, H (avg.)")



# Merge flagged and confirmed data:
flagNat$Jurisdiction <- "National Government"
confNat$Jurisdiction <- "National Government"
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, flagNat, by = c("CountryCode","Jurisdiction"), all.x = TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, flagSubNat, by = c("RegionCode"), all.x = TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, confNat, by = c("CountryCode","Jurisdiction"), all.x = TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, confSubNat, by = c("RegionCode"), all.x = TRUE)


#Flagged and confirmed days and dates: merge nat and subnat
OxCGRT_Coding_LastDate$Flagged_days_total <- rowSums(OxCGRT_Coding_LastDate[c(36,38)], na.rm = TRUE)
OxCGRT_Coding_LastDate$Pctg_flagged_days_total <- rowSums(OxCGRT_Coding_LastDate[c(37,39)], na.rm = TRUE)

OxCGRT_Coding_LastDate$Confirmed_days_total <- rowSums(OxCGRT_Coding_LastDate[c(40,42)], na.rm = TRUE)
OxCGRT_Coding_LastDate$Pctg_confirmed_days_total <- rowSums(OxCGRT_Coding_LastDate[c(41,43)], na.rm = TRUE)




# Identify how many days have been forgotten.

#library(tidyr)
#OxCGRT_Coding_LastDate$ForgottenBoxes <- 0
#OxCGRT_Coding_LastDate$ForgottenBoxes <- (((OxCGRT_Coding_LastDate$`Missing days (avg.)`)-
#                                             (OxCGRT_Coding_LastDate$`Outdated coding in days (avg.)`))*20)
#OxCGRT_Coding_LastDate <- separate(OxCGRT_Coding_LastDate, ForgottenBoxes,
#                                   sep = " ", into = c("Forgotten boxes (total)", "days"))



# Organize the spreadsheet
OxCGRT_Coding_LastDate <- select(OxCGRT_Coding_LastDate, c(4, 3, 29, 30, 31, 32, 33, 34, 35, 44:47, 5:14, 17:19, 22:28))
OxCGRT_Coding_LastDate <- OxCGRT_Coding_LastDate[order(OxCGRT_Coding_LastDate$CountryName,
                                                       -OxCGRT_Coding_LastDate$`Outdated coding in days C, H (avg.)`),]
names(OxCGRT_Coding_LastDate) [1] = "Country"

# Export in csv format 
write.table(OxCGRT_Coding_LastDate, file ="OxCGRT_coverage_status.csv", row.names = F, sep = ",", na="")

### For the US tab
US_OxCGRT_Coding_LastDate <- filter(OxCGRT_Coding_LastDate, Country == "United States" )
US_OxCGRT_Coding_LastDate <- select(US_OxCGRT_Coding_LastDate, c(2:33))
write.table(US_OxCGRT_Coding_LastDate, file ="US_OxCGRT_coverage_status.csv", row.names = F, sep = ",", na="")

### For the Brazil tab
BRA_OxCGRT_Coding_LastDate <- filter(OxCGRT_Coding_LastDate, Country == "Brazil" )
BRA_OxCGRT_Coding_LastDate <- select(BRA_OxCGRT_Coding_LastDate, c(2:33))
write.table(BRA_OxCGRT_Coding_LastDate, file ="BRA_OxCGRT_coverage_status.csv", row.names = F, sep = ",", na="")

### For the Canada tab
CAN_OxCGRT_Coding_LastDate <- filter(OxCGRT_Coding_LastDate, Country == "Canada" )
CAN_OxCGRT_Coding_LastDate <- select(CAN_OxCGRT_Coding_LastDate, c(2:33))
write.table(CAN_OxCGRT_Coding_LastDate, file ="CAN_OxCGRT_coverage_status.csv", row.names = F, sep = ",", na="")

### For the China tab
CHN_OxCGRT_Coding_LastDate <- filter(OxCGRT_Coding_LastDate, Country == "China" )
CHN_OxCGRT_Coding_LastDate <- select(CHN_OxCGRT_Coding_LastDate, c(2:33))
write.table(CHN_OxCGRT_Coding_LastDate, file ="CHN_OxCGRT_coverage_status.csv", row.names = F, sep = ",", na="")

### For the UK tab
UK_OxCGRT_Coding_LastDate <- filter(OxCGRT_Coding_LastDate, Country == "United Kingdom" )
UK_OxCGRT_Coding_LastDate <- select(UK_OxCGRT_Coding_LastDate, c(2:33))
write.table(UK_OxCGRT_Coding_LastDate, file ="UK_OxCGRT_coverage_status.csv", row.names = F, sep = ",", na="")

### For the Australia tab
AUS_OxCGRT_Coding_LastDate <- filter(OxCGRT_Coding_LastDate, Country == "Australia" )
AUS_OxCGRT_Coding_LastDate <- select(AUS_OxCGRT_Coding_LastDate, c(2:33))
write.table(AUS_OxCGRT_Coding_LastDate, file ="AUS_OxCGRT_coverage_status.csv", row.names = F, sep = ",", na="")

### For the India tab
IND_OxCGRT_Coding_LastDate <- filter(OxCGRT_Coding_LastDate, Country == "India" )
IND_OxCGRT_Coding_LastDate <- select(IND_OxCGRT_Coding_LastDate, c(2:33))
write.table(IND_OxCGRT_Coding_LastDate, file ="IND_OxCGRT_coverage_status.csv", row.names = F, sep = ",", na="")
