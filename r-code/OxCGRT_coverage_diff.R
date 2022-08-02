library(dplyr)

# Import data
#National dataset:
oxcgrt_nat_data <- read.csv(url("https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/OxCGRT_nat_latest.csv"))
#AUS Dataset:
oxcgrt_aus_data <- read.csv(url("https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/Australia/OxCGRT_AUS_latest.csv"))
#CAN Dataset:
oxcgrt_can_data <- read.csv(url("https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/Canada/OxCGRT_CAN_latest.csv"))
#GBR Dataset:
oxcgrt_gbr_data <- read.csv(url("https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/United%20Kingdom/OxCGRT_GBR_latest.csv"))
#USA Dataset:
oxcgrt_usa_data <- read.csv(url("https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/United%20States/OxCGRT_USA_latest.csv"))

#Remove NAT_TOTAL from Subnational data:

oxcgrt_aus_data <- 
  oxcgrt_aus_data %>% 
  filter(Jurisdiction == "STATE_TOTAL")

oxcgrt_can_data <- 
  oxcgrt_can_data %>% 
  filter(Jurisdiction == "STATE_TOTAL")

oxcgrt_gbr_data <- 
  oxcgrt_gbr_data %>% 
  filter(Jurisdiction == "STATE_TOTAL")

oxcgrt_usa_data <- 
  oxcgrt_usa_data %>% 
  filter(Jurisdiction == "STATE_TOTAL")

OxCGRTData <- rbind(oxcgrt_nat_data, oxcgrt_aus_data, oxcgrt_can_data, oxcgrt_gbr_data, oxcgrt_usa_data)

# Change date format
OxCGRTData$Date<- as.Date(as.character(OxCGRTData$Date),format = "%Y%m%d")

# Create an identifier for national-level policies
OxCGRTData$RegionName[OxCGRTData$RegionName==""] <- "National Government" 

# Last day of coding for each indicator
c1m <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(C1M_School.closing!="NA")]))

c2m <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(C2M_Workplace.closing!="NA")]))

c3m <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(C3M_Cancel.public.events!="NA")]))

c4m <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(C4M_Restrictions.on.gatherings!="NA")]))

c5m <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(C5M_Close.public.transport!="NA")]))

c6m <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(C6M_Stay.at.home.requirements!="NA")]))

c7m <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(C7M_Restrictions.on.internal.movement!="NA")]))

c8ev <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(C8EV_International.travel.controls!="NA")]))

e1 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(E1_Income.support!="NA")]))

e2 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(E2_Debt.contract.relief!="NA")]))

e3 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(E3_Fiscal.measures!="NA")]))

e4 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(E4_International.support!="NA")]))

h1 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(H1_Public.information.campaigns!="NA")]))

h2 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(H2_Testing.policy!="NA")]))

h3 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(H3_Contact.tracing!="NA")]))

h4 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(H4_Emergency.investment.in.healthcare!="NA")]))

h5 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(H5_Investment.in.vaccines!="NA")]))

h6m <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(H6M_Facial.Coverings!="NA")]))

h7 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(H7_Vaccination.policy!="NA")]))

h8m <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(H8M_Protection.of.elderly.people!="NA")]))

# Merge the dataframes into one
OxCGRT_Coding_LastDate <- merge(c1m, c2m, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c3m, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c4m, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c5m, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c6m, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c7m, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c8ev, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, e1, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, e2, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, e3, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, e4, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h1, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h2, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h3, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h4, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h5, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h6m, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h7, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h8m, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))


# Identify how many days are out of date for each indicator, except E3, E4, H4 and H5.
  
  #Set current date
OxCGRT_Coding_LastDate$current_date <- Sys.Date()

OxCGRT_Coding_LastDate$outdate_days <- ((OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(C1M_School.closing != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(C2M_Workplace.closing != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(C3M_Cancel.public.events != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(C4M_Restrictions.on.gatherings != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(C5M_Close.public.transport != "NA")])`) +                                          
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(C6M_Stay.at.home.requirements != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(C7M_Restrictions.on.internal.movement != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(C8EV_International.travel.controls != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(E1_Income.support != "NA")])`) +                                          
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(E2_Debt.contract.relief != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(H1_Public.information.campaigns != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(H2_Testing.policy != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(H3_Contact.tracing != "NA")])`) +                                          
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(H6M_Facial.Coverings != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(H7_Vaccination.policy != "NA")])`) +                                          
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(H8M_Protection.of.elderly.people != "NA")])`)) / 16

# Identify how many days are missing for each indicator, except E3, E4, H4 and H5.
c1m_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(C1M_School.closing)))

c2m_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(C2M_Workplace.closing)))

c3m_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(C3M_Cancel.public.events)))

c4m_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(C4M_Restrictions.on.gatherings)))

c5m_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(C5M_Close.public.transport)))

c6m_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(C6M_Stay.at.home.requirements)))

c7m_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(C7M_Restrictions.on.internal.movement)))

c8ev_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(C8EV_International.travel.controls)))

e1_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(E1_Income.support)))

e2_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(E2_Debt.contract.relief)))

h1_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(H1_Public.information.campaigns)))

h2_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(H2_Testing.policy)))

h3_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(H3_Contact.tracing)))

h6m_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(H6M_Facial.Coverings)))

h7_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(H7_Vaccination.policy)))

h8m_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(H8M_Protection.of.elderly.people)))


OxCGRT_missing <- merge(c1m_missing, c2m_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, c3m_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, c4m_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, c5m_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, c6m_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, c7m_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, c8ev_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, e1_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, e2_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, h1_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, h2_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, h3_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, h6m_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, h7_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_missing <- merge(OxCGRT_missing, h8m_missing, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))

OxCGRT_Coding_LastDate$missing_days <- ((OxCGRT_missing[,5]) + (OxCGRT_missing[,6]) + (OxCGRT_missing[,7]) + 
                                          (OxCGRT_missing[,8]) + (OxCGRT_missing[,9]) + (OxCGRT_missing[,10]) + 
                                          (OxCGRT_missing[,11]) + (OxCGRT_missing[,12]) + (OxCGRT_missing[,13]) + 
                                          (OxCGRT_missing[,14]) + (OxCGRT_missing[,15]) + (OxCGRT_missing[,16]) + 
                                          (OxCGRT_missing[,17]) + (OxCGRT_missing[,18]) + (OxCGRT_missing[,19]) + 
                                          (OxCGRT_missing[,20])) / 16


# Label variables
names(OxCGRT_Coding_LastDate) = c("CountryName", "Jurisdiction", "CountryCode", "RegionCode", "C1M: School closing", "C2M: Workplace closing",
                                  "C3M: Cancel public events", "C4M: Restrictions on gatherings",
                                  "C5M: Close public transport", "C6M: Stay at home requirements",
                                  "C7M: Restrictions on internal movement", "C8EV: International travel controls",
                                  "E1: Income support", "E2: Debt/contract relief", "E3: Fiscal measures",
                                  "E4: International support", "H1: Public information campaigns", "H2: Testing policy",
                                  "H3: Contact tracing", "H4: Emergency investment in healthcare",
                                  "H5: Investment in vaccines", "H6M: Facial Coverings", "H7: Vaccination policy",
                                  "H8M: Protection of elderly people","Current date", "Outdated coding in days (avg.)",
                                  "Missing days (avg.)")


# Organize the spreadsheet
#OxCGRT_Coding_LastDate <- select(OxCGRT_Coding_LastDate, c(4, 3, 25:26, 30:31, 5:24, 27))
#OxCGRT_Coding_LastDate <- OxCGRT_Coding_LastDate[order(OxCGRT_Coding_LastDate$CountryName,
#                                                       -OxCGRT_Coding_LastDate$`Outdated coding in days (avg.)`),]
#names(OxCGRT_Coding_LastDate) [1] = "Country"

# Export in csv format 
write.table(OxCGRT_Coding_LastDate, file =".covid-policy-scratchpad/OxCGRT_coverage_status/Differentiated_coverage/OxCGRT_diff_coverage_status.csv", row.names = F, sep = ",", na="")

### For the Canada tab
CAN_OxCGRT_Coding_LastDate <- filter(OxCGRT_Coding_LastDate, Country == "Canada" )
CAN_OxCGRT_Coding_LastDate <- select(CAN_OxCGRT_Coding_LastDate, c(2:27))
write.table(CAN_OxCGRT_Coding_LastDate, file =".covid-policy-scratchpad/OxCGRT_coverage_status/Differentiated_coverage/CAN_OxCGRT_diff_coverage_status.csv", row.names = F, sep = ",", na="")

### For the UK tab
UK_OxCGRT_Coding_LastDate <- filter(OxCGRT_Coding_LastDate, Country == "United Kingdom" )
UK_OxCGRT_Coding_LastDate <- select(UK_OxCGRT_Coding_LastDate, c(2:27))
write.table(UK_OxCGRT_Coding_LastDate, file =".covid-policy-scratchpad/OxCGRT_coverage_status/Differentiated_coverage/UK_OxCGRT_diff_coverage_status.csv", row.names = F, sep = ",", na="")

### For the US tab
US_OxCGRT_Coding_LastDate <- filter(OxCGRT_Coding_LastDate, Country == "United States" )
US_OxCGRT_Coding_LastDate <- select(US_OxCGRT_Coding_LastDate, c(2:27))
write.table(US_OxCGRT_Coding_LastDate, file =".covid-policy-scratchpad/OxCGRT_coverage_status/Differentiated_coverage/US_OxCGRT_diff_coverage_status.csv", row.names = F, sep = ",", na="")

### For the Australia tab
US_OxCGRT_Coding_LastDate <- filter(OxCGRT_Coding_LastDate, Country == "Australia" )
US_OxCGRT_Coding_LastDate <- select(US_OxCGRT_Coding_LastDate, c(2:27))
write.table(US_OxCGRT_Coding_LastDate, file =".covid-policy-scratchpad/OxCGRT_diff_coverage_status/Differentiated_coverage/AUS_OxCGRT_coverage_status.csv", row.names = F, sep = ",", na="")
