# Import data
OxCGRTData <- read.csv(url("https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/OxCGRT_latest.csv"))

# Change date format
OxCGRTData$Date<- as.Date(as.character(OxCGRTData$Date),format = "%Y%m%d")

# Create an identifier for national-level policies
OxCGRTData$RegionName[OxCGRTData$RegionName==""] <- "National Government" 

# Last day of coding for each indicator
library(dplyr)

c1 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(C1_School.closing!="NA")]))

c2 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(C2_Workplace.closing!="NA")]))

c3 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(C3_Cancel.public.events!="NA")]))

c4 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(C4_Restrictions.on.gatherings!="NA")]))

c5 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(C5_Close.public.transport!="NA")]))

c6 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(C6_Stay.at.home.requirements!="NA")]))

c7 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(C7_Restrictions.on.internal.movement!="NA")]))

c8 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(C8_International.travel.controls!="NA")]))

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

h6 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(H6_Facial.Coverings!="NA")]))

h7 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(H7_Vaccination.policy!="NA")]))

h8 <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(max(Date[which(H8_Protection.of.elderly.people!="NA")]))

# Flagged data points (national-level policies)
date <- Sys.Date()
file_path_nat <- paste0("https://oxcgrtportal.azurewebsites.net/api/statscsv?Provisional=false&Confirmed=false&ToRecode=false&Flagged=true&Nat=true&FromDate=2020-01-01&ToDate=", date)
flagNat <- read.csv(file_path_nat, header = TRUE, sep = ",")
flagNat$flagcount <-rowSums(flagNat[c(2:11, 14:16, 19:21)], na.rm = TRUE)
flagNat <- select(flagNat, c(1,26))
names(flagNat) = c("CountryCode", "Flagged data")

# Flagged data points (subnational policies)
file_path_subnat <- paste0("https://oxcgrtportal.azurewebsites.net/api/statscsv?Provisional=false&Confirmed=false&ToRecode=false&Flagged=true&SubNat=true&FromDate=2020-01-01&ToDate=", date)
flagSubNat <- read.csv(file_path_subnat, header = TRUE, sep = ",")
flagSubNat$flagcount <-rowSums(flagSubNat[c(4:13, 16:18, 21:23)], na.rm = TRUE)

flagSubNat <- subset(flagSubNat, Country %in% c("BRA", "CAN", "CHN", "GBR", "USA", "AUS", "IND"))
flagSubNat <- select(flagSubNat, c(2,28))
names(flagSubNat) = c("RegionCode", "Flagged data")
flagSubNat <- flagSubNat%>%group_by(RegionCode)%>%summarise_all(funs(sum))

# Merge the dataframes into one
OxCGRT_Coding_LastDate <- merge(c1, c2, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c3, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c4, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c5, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c6, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c7, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c8, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, e1, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, e2, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, e3, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, e4, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h1, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h2, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h3, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h4, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h5, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h6, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h7, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h8, by = c("CountryName","RegionName", "CountryCode", "RegionCode"))

# Identify how many days are out of date for each indicator, except E3, E4, H4 and H5.
OxCGRT_Coding_LastDate$current_date <- Sys.Date()
OxCGRT_Coding_LastDate$outdate_days <- ((OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(C1_School.closing != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(C2_Workplace.closing != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(C3_Cancel.public.events != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(C4_Restrictions.on.gatherings != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(C5_Close.public.transport != "NA")])`) +                                          
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(C6_Stay.at.home.requirements != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(C7_Restrictions.on.internal.movement != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(C8_International.travel.controls != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(E1_Income.support != "NA")])`) +                                          
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(E2_Debt.contract.relief != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(H1_Public.information.campaigns != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(H2_Testing.policy != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(H3_Contact.tracing != "NA")])`) +                                          
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(H6_Facial.Coverings != "NA")])`) +
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(H7_Vaccination.policy != "NA")])`) +                                          
                                          (OxCGRT_Coding_LastDate$current_date - OxCGRT_Coding_LastDate$`max(Date[which(H8_Protection.of.elderly.people != "NA")])`)) / 16


# Identify how many days are missing for each indicator, except E3, E4, H4 and H5.
c1_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(C1_School.closing)))

c2_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(C2_Workplace.closing)))

c3_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(C3_Cancel.public.events)))

c4_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(C4_Restrictions.on.gatherings)))

c5_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(C5_Close.public.transport)))

c6_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(C6_Stay.at.home.requirements)))

c7_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(C7_Restrictions.on.internal.movement)))

c8_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(C8_International.travel.controls)))

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

h6_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(H6_Facial.Coverings)))

h7_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(H7_Vaccination.policy)))

h8_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName, CountryCode, RegionCode) %>%
  summarise(column = sum(count = is.na(H8_Protection.of.elderly.people)))


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

OxCGRT_Coding_LastDate$missing_days <- ((OxCGRT_missing[,5]) + (OxCGRT_missing[,6]) + (OxCGRT_missing[,7]) + 
                                          (OxCGRT_missing[,8]) + (OxCGRT_missing[,9]) + (OxCGRT_missing[,10]) + 
                                          (OxCGRT_missing[,11]) + (OxCGRT_missing[,12]) + (OxCGRT_missing[,13]) + 
                                          (OxCGRT_missing[,14]) + (OxCGRT_missing[,15]) + (OxCGRT_missing[,16]) + 
                                          (OxCGRT_missing[,17]) + (OxCGRT_missing[,18]) + (OxCGRT_missing[,19]) + 
                                          (OxCGRT_missing[,20])) / 16


# Label variables
names(OxCGRT_Coding_LastDate) = c("CountryName", "Jurisdiction", "CountryCode", "RegionCode", "C1: School closing", "C2: Workplace closing",
                                  "C3: Cancel public events", "C4: Restrictions on gatherings",
                                  "C5: Close public transport", "C6: Stay at home requirements",
                                  "C7: Restrictions on internal movement", "C8: International travel controls",
                                  "E1: Income support", "E2: Debt/contract relief", "E3: Fiscal measures",
                                  "E4: International support", "H1: Public information campaigns", "H2: Testing policy",
                                  "H3: Contact tracing", "H4: Emergency investment in healthcare",
                                  "H5: Investment in vaccines", "H6: Facial Coverings", "H7: Vaccination policy",
                                  "H8: Protection of elderly people","Current date", "Outdated coding in days (avg.)",
                                  "Missing days (avg.)")

# Identify how many days have been flagged for reviewer attention.
flagNat$Jurisdiction <- "National Government"
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, flagNat, by = c("CountryCode","Jurisdiction"), all.x = TRUE)
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, flagSubNat, by = c("RegionCode"), all.x = TRUE)
OxCGRT_Coding_LastDate$`Flagged days (total)` <- rowSums(OxCGRT_Coding_LastDate[c(28:29)], na.rm = TRUE)

# Identify how many days have been forgotten.
library(tidyr)
OxCGRT_Coding_LastDate$ForgottenBoxes <- 0
OxCGRT_Coding_LastDate$ForgottenBoxes <- (((OxCGRT_Coding_LastDate$`Missing days (avg.)`)-
                                                (OxCGRT_Coding_LastDate$`Outdated coding in days (avg.)`))*16)
OxCGRT_Coding_LastDate <- separate(OxCGRT_Coding_LastDate, ForgottenBoxes,
                                      sep = " ", into = c("Forgotten boxes (total)", "days"))

# Organize the spreadsheet
OxCGRT_Coding_LastDate <- select(OxCGRT_Coding_LastDate, c(4, 3, 25:26, 30:31, 5:24, 27))
OxCGRT_Coding_LastDate <- OxCGRT_Coding_LastDate[order(OxCGRT_Coding_LastDate$CountryName,
                                                       -OxCGRT_Coding_LastDate$`Outdated coding in days (avg.)`),]
names(OxCGRT_Coding_LastDate) [1] = "Country"

# Export in csv format 
write.table(OxCGRT_Coding_LastDate, file ="OxCGRT_coverage_status.csv", row.names = F, sep = ",", na="")

### For the Brazil tab
BRA_OxCGRT_Coding_LastDate <- filter(OxCGRT_Coding_LastDate, Country == "Brazil" )
BRA_OxCGRT_Coding_LastDate <- select(BRA_OxCGRT_Coding_LastDate, c(2:27))
write.table(BRA_OxCGRT_Coding_LastDate, file ="BRA_OxCGRT_coverage_status.csv", row.names = F, sep = ",", na="")

### For the Canada tab
CAN_OxCGRT_Coding_LastDate <- filter(OxCGRT_Coding_LastDate, Country == "Canada" )
CAN_OxCGRT_Coding_LastDate <- select(CAN_OxCGRT_Coding_LastDate, c(2:27))
write.table(CAN_OxCGRT_Coding_LastDate, file ="CAN_OxCGRT_coverage_status.csv", row.names = F, sep = ",", na="")

### For the China tab
CHN_OxCGRT_Coding_LastDate <- filter(OxCGRT_Coding_LastDate, Country == "China" )
CHN_OxCGRT_Coding_LastDate <- select(CHN_OxCGRT_Coding_LastDate, c(2:27))
write.table(CHN_OxCGRT_Coding_LastDate, file ="CHN_OxCGRT_coverage_status.csv", row.names = F, sep = ",", na="")

### For the UK tab
UK_OxCGRT_Coding_LastDate <- filter(OxCGRT_Coding_LastDate, Country == "United Kingdom" )
UK_OxCGRT_Coding_LastDate <- select(UK_OxCGRT_Coding_LastDate, c(2:27))
write.table(UK_OxCGRT_Coding_LastDate, file ="UK_OxCGRT_coverage_status.csv", row.names = F, sep = ",", na="")

### For the US tab
US_OxCGRT_Coding_LastDate <- filter(OxCGRT_Coding_LastDate, Country == "United States" )
US_OxCGRT_Coding_LastDate <- select(US_OxCGRT_Coding_LastDate, c(2:27))
write.table(US_OxCGRT_Coding_LastDate, file ="US_OxCGRT_coverage_status.csv", row.names = F, sep = ",", na="")

### For the Australia tab
US_OxCGRT_Coding_LastDate <- filter(OxCGRT_Coding_LastDate, Country == "Australia" )
US_OxCGRT_Coding_LastDate <- select(US_OxCGRT_Coding_LastDate, c(2:27))
write.table(US_OxCGRT_Coding_LastDate, file ="AUS_OxCGRT_coverage_status.csv", row.names = F, sep = ",", na="")

### For the India tab
US_OxCGRT_Coding_LastDate <- filter(OxCGRT_Coding_LastDate, Country == "India" )
US_OxCGRT_Coding_LastDate <- select(US_OxCGRT_Coding_LastDate, c(2:27))
write.table(US_OxCGRT_Coding_LastDate, file ="IND_OxCGRT_coverage_status.csv", row.names = F, sep = ",", na="")

