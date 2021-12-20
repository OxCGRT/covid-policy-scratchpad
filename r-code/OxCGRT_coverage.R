# Import data now
OxCGRTData <- read.csv(url("https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/OxCGRT_latest.csv"))

# Change date format
OxCGRTData$Date<- as.Date(as.character(OxCGRTData$Date),format = "%Y%m%d")

# Create an identifier for national-level policies
OxCGRTData$RegionName[OxCGRTData$RegionName==""] <- "National Government"

# Last day of coding for each indicator
library(dplyr)

c1 <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(max(Date[which(C1_School.closing!="NA")]))

c2 <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(max(Date[which(C2_Workplace.closing!="NA")]))

c3 <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(max(Date[which(C3_Cancel.public.events!="NA")]))

c4 <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(max(Date[which(C4_Restrictions.on.gatherings!="NA")]))

c5 <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(max(Date[which(C5_Close.public.transport!="NA")]))

c6 <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(max(Date[which(C6_Stay.at.home.requirements!="NA")]))

c7 <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(max(Date[which(C7_Restrictions.on.internal.movement!="NA")]))

c8 <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(max(Date[which(C8_International.travel.controls!="NA")]))

e1 <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(max(Date[which(E1_Income.support!="NA")]))

e2 <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(max(Date[which(E2_Debt.contract.relief!="NA")]))

e3 <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(max(Date[which(E3_Fiscal.measures!="NA")]))

e4 <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(max(Date[which(E4_International.support!="NA")]))

h1 <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(max(Date[which(H1_Public.information.campaigns!="NA")]))

h2 <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(max(Date[which(H2_Testing.policy!="NA")]))

h3 <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(max(Date[which(H3_Contact.tracing!="NA")]))

h4 <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(max(Date[which(H4_Emergency.investment.in.healthcare!="NA")]))

h5 <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(max(Date[which(H5_Investment.in.vaccines!="NA")]))

h6 <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(max(Date[which(H6_Facial.Coverings!="NA")]))

h7 <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(max(Date[which(H7_Vaccination.policy!="NA")]))

h8 <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(max(Date[which(H8_Protection.of.elderly.people!="NA")]))

# Merge the dataframes into one
OxCGRT_Coding_LastDate <- merge(c1, c2, by = c("CountryName","RegionName"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c3, by = c("CountryName","RegionName"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c4, by = c("CountryName","RegionName"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c5, by = c("CountryName","RegionName"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c6, by = c("CountryName","RegionName"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c7, by = c("CountryName","RegionName"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, c8, by = c("CountryName","RegionName"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, e1, by = c("CountryName","RegionName"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, e2, by = c("CountryName","RegionName"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, e3, by = c("CountryName","RegionName"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, e4, by = c("CountryName","RegionName"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h1, by = c("CountryName","RegionName"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h2, by = c("CountryName","RegionName"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h3, by = c("CountryName","RegionName"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h4, by = c("CountryName","RegionName"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h5, by = c("CountryName","RegionName"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h6, by = c("CountryName","RegionName"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h7, by = c("CountryName","RegionName"))
OxCGRT_Coding_LastDate <- merge(OxCGRT_Coding_LastDate, h8, by = c("CountryName","RegionName"))

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
  group_by(CountryName, RegionName) %>%
  summarise(column = sum(count = is.na(C1_School.closing)))

c2_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(column = sum(count = is.na(C2_Workplace.closing)))

c3_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(column = sum(count = is.na(C3_Cancel.public.events)))

c4_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(column = sum(count = is.na(C4_Restrictions.on.gatherings)))

c5_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(column = sum(count = is.na(C5_Close.public.transport)))

c6_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(column = sum(count = is.na(C6_Stay.at.home.requirements)))

c7_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(column = sum(count = is.na(C7_Restrictions.on.internal.movement)))

c8_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(column = sum(count = is.na(C8_International.travel.controls)))

e1_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(column = sum(count = is.na(E1_Income.support)))

e2_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(column = sum(count = is.na(E2_Debt.contract.relief)))


h1_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(column = sum(count = is.na(H1_Public.information.campaigns)))

h2_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(column = sum(count = is.na(H2_Testing.policy)))

h3_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(column = sum(count = is.na(H3_Contact.tracing)))

h6_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(column = sum(count = is.na(H6_Facial.Coverings)))

h7_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(column = sum(count = is.na(H7_Vaccination.policy)))

h8_missing <-OxCGRTData %>%
  group_by(CountryName, RegionName) %>%
  summarise(column = sum(count = is.na(H8_Protection.of.elderly.people)))


OxCGRT_missing <- merge(c1_missing, c2_missing, by = c("CountryName","RegionName"))
OxCGRT_missing <- merge(OxCGRT_missing, c3_missing, by = c("CountryName","RegionName"))
OxCGRT_missing <- merge(OxCGRT_missing, c4_missing, by = c("CountryName","RegionName"))
OxCGRT_missing <- merge(OxCGRT_missing, c5_missing, by = c("CountryName","RegionName"))
OxCGRT_missing <- merge(OxCGRT_missing, c6_missing, by = c("CountryName","RegionName"))
OxCGRT_missing <- merge(OxCGRT_missing, c7_missing, by = c("CountryName","RegionName"))
OxCGRT_missing <- merge(OxCGRT_missing, c8_missing, by = c("CountryName","RegionName"))
OxCGRT_missing <- merge(OxCGRT_missing, e1_missing, by = c("CountryName","RegionName"))
OxCGRT_missing <- merge(OxCGRT_missing, e2_missing, by = c("CountryName","RegionName"))
OxCGRT_missing <- merge(OxCGRT_missing, h1_missing, by = c("CountryName","RegionName"))
OxCGRT_missing <- merge(OxCGRT_missing, h2_missing, by = c("CountryName","RegionName"))
OxCGRT_missing <- merge(OxCGRT_missing, h3_missing, by = c("CountryName","RegionName"))
OxCGRT_missing <- merge(OxCGRT_missing, h6_missing, by = c("CountryName","RegionName"))
OxCGRT_missing <- merge(OxCGRT_missing, h7_missing, by = c("CountryName","RegionName"))
OxCGRT_missing <- merge(OxCGRT_missing, h8_missing, by = c("CountryName","RegionName"))

OxCGRT_Coding_LastDate$missing_days <- ((OxCGRT_missing[,3]) + (OxCGRT_missing[,4]) + (OxCGRT_missing[,5]) +
                                          (OxCGRT_missing[,6]) + (OxCGRT_missing[,7]) + (OxCGRT_missing[,8]) +
                                          (OxCGRT_missing[,9]) + (OxCGRT_missing[,10]) + (OxCGRT_missing[,11]) +
                                          (OxCGRT_missing[,12]) + (OxCGRT_missing[,13]) + (OxCGRT_missing[,14]) +
                                          (OxCGRT_missing[,15]) + (OxCGRT_missing[,16]) + (OxCGRT_missing[,17]) +
                                          (OxCGRT_missing[,18])) / 16


# Label variables
names(OxCGRT_Coding_LastDate) = c("Country", "Region", "C1: School closing", "C2: Workplace closing",
                                  "C3: Cancel public events", "C4: Restrictions on gatherings",
                                  "C5: Close public transport", "C6: Stay at home requirements",
                                  "C7: Restrictions on internal movement", "C8: International travel controls",
                                  "E1: Income support", "E2: Debt/contract relief", "E3: Fiscal measures",
                                  "E4: International support", "H1: Public information campaigns", "H2: Testing policy",
                                  "H3: Contact tracing", "H4: Emergency investment in healthcare",
                                  "H5: Investment in vaccines", "H6: Facial Coverings", "H7: Vaccination policy",
                                  "H8: Protection of elderly people","Current date", "Outdated coding in days (avg.)",
                                  "Missing days (avg.)")



# Export in csv format
write.table(OxCGRT_Coding_LastDate, file ="OxCGRT_coverage_status.csv", row.names = F, sep = ",", na="")


#####For the US tab

#US_OxCGRT_Coding_LastDate <- filter(OxCGRT_Coding_LastDate, Country == "United States" )
#US_OxCGRT_Coding_LastDate <- rename(US_OxCGRT_Coding_LastDate, "Jurisdiction" = Region)
#US_OxCGRT_Coding_LastDate <- select(US_OxCGRT_Coding_LastDate, c(2, 23:25, 3:22))
#US_OxCGRT_Coding_LastDate$ForgottenBoxes <- 0
#US_OxCGRT_Coding_LastDate$ForgottenBoxes <- (((US_OxCGRT_Coding_LastDate$`Missing days (avg.)`)-
#                        (US_OxCGRT_Coding_LastDate$`Outdated coding in days (avg.)`))*16)
#US_OxCGRT_Coding_LastDate <- separate(US_OxCGRT_Coding_LastDate, ForgottenBoxes,
 #                   sep = " ", into = c("ForgottenBoxes", "days"))
#US_OxCGRT_Coding_LastDate <- select(US_OxCGRT_Coding_LastDate, c(1:3, 25, 5:24, 4))


# Export US in csv format
#write.table(US_OxCGRT_Coding_LastDate, file ="US_OxCGRT_coverage_status.csv", row.names = F, sep = ",", na="")



