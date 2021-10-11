library(dplyr)
library(ggplot2)
library(scales)
library(readr)
library(tidyr)
library(lubridate)

url_oxcgrt <- "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/OxCGRT_latest_allchanges.csv"

oxcgrtdata <- read_csv(url(url_oxcgrt),
                      locale = readr::locale(encoding = "Latin1"))

# define WB regions ----------------------------------------------
East_Asia_Pacific <- c("ASM", "AUS", "BRN", "CHN", "FJI", "FSM", "GUM", "HKG", "IDN", "JPN", "KHM", "KIR", "KOR", "LAO", "MAC", "MHL", "MMR", "MNG", "MNP", "MYS", "NCL", "NRU", "NZL", "PHL", "PLW", "PNG", "PRK", "PYF", "SGP", "SLB", "THA", "TLS", "TON", "TUV", "TWN", "VNM", "VUT", "WSM")
Europe_Central_Asia <- c("ALB", "AND", "ARM", "AUT", "AZE", "BEL", "BGR", "BIH", "BLR", "CHE", "CHI", "CYP", "CZE", "DEU", "DNK", "ESP", "EST", "FIN", "FRA", "FRO", "GBR", "GEO", "GIB", "GRC", "GRL", "HRV", "HUN", "IMN", "IRL", "ISL", "ITA", "KAZ", "KGZ", "LIE", "LTU", "LUX", "LVA", "MCO", "MDA", "MKD", "MNE", "NLD", "NOR", "POL", "PRT", "ROU", "RUS", "SMR", "SRB", "SVK", "SVN", "SWE", "TJK", "TKM", "TUR", "UKR", "UZB", "RKS")
Latin_America_Caribbean <- c("ABW", "ARG", "ATG", "BHS", "BLZ", "BOL", "BRA", "BRB", "CHL", "COL", "CRI", "CUB", "CUW", "CYM", "DMA", "DOM", "ECU", "GRD", "GTM", "GUY", "HND", "HTI", "JAM", "KNA", "LCA", "MAF", "MEX", "NIC", "PAN", "PER", "PRI", "PRY", "SLV", "SUR", "SXM", "TCA", "TTO", "URY", "VCT", "VEN", "VGB", "VIR")
Middle_East_North_Africa <- c("ARE", "BHR", "DJI", "DZA", "EGY", "IRN", "IRQ", "ISR", "JOR", "KWT", "LBN", "LBY", "MAR", "MLT", "OMN", "PSE", "QAT", "SAU", "SYR", "TUN", "YEM")
North_America <- c("BMU", "CAN", "USA")
South_Asia <- c("AFG", "BGD", "BTN", "IND", "LKA", "MDV", "NPL", "PAK")
sub_Saharan_Africa <- c("AGO", "BDI", "BEN", "BFA", "BWA", "CAF", "CIV", "CMR", "COD", "COG", "COM", "CPV", "ERI", "ETH", "GAB", "GHA", "GIN", "GMB", "GNB", "GNQ", "KEN", "LBR", "LSO", "MDG", "MLI", "MOZ", "MRT", "MUS", "MWI", "NAM", "NER", "NGA", "RWA", "SDN", "SEN", "SLE", "SOM", "SSD", "STP", "SWZ", "SYC", "TCD", "TGO", "TZA", "UGA", "ZAF", "ZMB", "ZWE")
region_list <- c("East_Asia_Pacific", "Europe_Central_Asia", "Latin_America_Caribbean", "Middle_East_North_Africa", "North_America", "South_Asia", "sub_Saharan_Africa")

oxcgrtdata$region <- NA

for(reg in region_list){
  regional <- get(reg)
  oxcgrtdata <- 
    oxcgrtdata %>% 
    mutate(region = ifelse(CountryCode %in% regional, reg, region))
}

# shortlist all changes within the last 5 weeks and create current and previous code ------------------
oxcgrtdata <- 
  oxcgrtdata %>%
  mutate(FlagCode = case_when(Flag == 1 ~ "G",
                              Flag == 0 ~ "T")) %>%
  mutate(PolicyCode = ifelse(!is.na(FlagCode), paste0(as.character(.$PolicyValue), .$FlagCode), as.character(PolicyValue))) %>%
  group_by(CountryCode, PolicyType) %>%
  arrange(CountryCode, PolicyType, Date) %>%
  mutate(previous_PolicyCode = lag(PolicyCode),
         Date = ymd(Date)) %>%
  ungroup() %>%
  filter(Date > Sys.Date() - 36) %>%
  select(CountryName, CountryCode, Date, region, PolicyType, PolicyCode, previous_PolicyCode, Notes,  -PolicyValue, -Flag, -FlagCode)

# subset by region and crate regional changes csv ---------------------
for(i in region_list){
  temp_tibble <- 
    oxcgrtdata %>%
    filter(region == !!i)
  write.csv(temp_tibble, file = paste0("latest_", i, ".csv"))
}

# Cases v/s Government Response Index graphs ------------------
url_oxcgrt <- "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/OxCGRT_latest.csv"

oxcgrtdata <- read_csv(url(url_oxcgrt), 
                       col_types = cols(RegionName = col_character(), 
                                        RegionCode = col_character()))

oxcgrtdata <- 
  oxcgrtdata %>%
  filter(is.na(RegionName)) %>%
  mutate(Date = ymd(Date)) %>%
  group_by(CountryCode) %>%
  arrange(CountryCode, Date) %>%
  fill(ConfirmedCases, .direction = "down") %>%
  mutate(log10_cases = log10(ConfirmedCases + 1))

oxcgrtdata$region <- NA

for(reg in region_list){
  regional <- get(reg)
  oxcgrtdata <- 
    oxcgrtdata %>% 
    mutate(region = ifelse(CountryCode %in% regional, reg, region))
}

for(i in region_list){
  # subset the data by region
  temp_tibble <- 
    oxcgrtdata %>%
    filter(region == !!i) %>%
    select(ContainmentHealthIndexForDisplay, ConfirmedCases, CountryName, CountryCode, Date, log10_cases)
  
  # find total number of countries in region and define other locals
  total_countries <- length(unique(temp_tibble$CountryCode))
  max_logcases <- ceiling(max(temp_tibble$log10_cases, na.rm = T))
  coeff <- 100/max_logcases
  maxDate <- max(unique(temp_tibble$Date))
  
  # create graph if only one page is needed i.e. total countries < 32 in region
  if(total_countries < 32){
    deficit <- 32 - total_countries
    # create the NA values to fill up the deficit number of countries
    for(j in seq(1:deficit)){
      agg_tibble <-
        temp_tibble %>%
        ungroup() %>%
        select(CountryName, Date) %>%
        mutate(CountryName = NA) %>%
        unique() %>%
        mutate(CountryName = paste0(rep(" ", times = j), collapse = ""))
      temp_tibble <- 
        bind_rows(temp_tibble, agg_tibble)
    }
    levels <- unique(temp_tibble$CountryName)
    # define levels for ordering the facet wrap
    temp_tibble <-
      temp_tibble %>%
      mutate(country_group = factor(CountryName, levels = levels))
    # create plot
    plot <-
      ggplot(data = temp_tibble, aes(x = Date)) + 
      geom_line(aes(y = log10_cases), colour = "purple") +
      geom_line(aes(y = ContainmentHealthIndexForDisplay/coeff), colour = "red") +
      scale_y_continuous(name = "Reported cases",
                         breaks = seq(0, max_logcases),
                         labels = comma(do.call(rbind,lapply(seq(0, max_logcases), function(x){return(10^x)}))),
                         sec.axis = sec_axis(~.*coeff,
                                             name = "Containment and Health Index",
                                             breaks = c(0, 20, 40, 60, 80, 100), 
                                             labels = c(0, 20, 40, 60, 80, 100))) + 
      expand_limits(y = c(0, max_logcases)) + 
      scale_x_date(breaks = seq.Date(from = ymd(as.Date("2020-01-01")), to = maxDate, by = "2 month"),
                   date_labels = "%d-%b") +
      labs(#title = paste0(i, "'s Covid-19 Trajectory"),
           caption = "Source: Oxford COVID-19 Government Response Tracker. More at https://github.com/OxCGRT/covid-policy-tracker 
       or bsg.ox.ac.uk/covidtracker") +
      theme(
        # Remove panel border
        axis.text.y.right = element_text(colour = "red"),
        axis.title.y.right = element_text(colour = "red"),
        axis.text.y.left = element_text(colour = "purple"),
        axis.title.y.left = element_text(colour = "purple"),
        panel.border = element_blank(),  
        # Remove panel grid lines
        panel.grid.major = element_line(size = 0.5, linetype = "dashed", colour = "grey"),
        #panel.grid.minor = element_blank(),
        # Remove panel background
        panel.background = element_blank(),
        # Add axis line
        axis.line = element_line(colour = "grey"),
        plot.caption = element_text(hjust = 0.5, face = "italic"),
        plot.title = element_text(hjust = 0.5)) + 
      facet_wrap(~country_group, ncol = 4)
    ggsave(plot = plot,
           filename = paste0("charts_", i, ".eps"),
           device = "eps",
           height = 20,
           width = 15)

  } else{
    for(j in c(1,2)){
      if(j == 1){
        countries <- unique(temp_tibble$CountryName)[1:32]
        plot <-
          ggplot(data = temp_tibble %>% filter(CountryName %in% countries), aes(x = Date)) + 
          geom_line(aes(y = log10_cases), colour = "purple") +
          geom_line(aes(y = ContainmentHealthIndexForDisplay/coeff), colour = "red") +
          scale_y_continuous(name = "Reported cases",
                             breaks = seq(0, max_logcases),
                             labels = comma(do.call(rbind,lapply(seq(0, max_logcases), function(x){return(10^x)}))),
                             sec.axis = sec_axis(~.*coeff,
                                                 name = "Containment and Health Index",
                                                 breaks = c(0, 20, 40, 60, 80, 100), 
                                                 labels = c(0, 20, 40, 60, 80, 100))) + 
          expand_limits(y = c(0, max_logcases)) + 
          scale_x_date(breaks = seq.Date(from = ymd(as.Date("2020-01-01")), to = maxDate, by = "2 month"),
                       date_labels = "%d-%b") +
          labs(#title = paste0(i, "'s Covid-19 Trajectory"),
            caption = "Source: Oxford COVID-19 Government Response Tracker. More at https://github.com/OxCGRT/covid-policy-tracker 
       or bsg.ox.ac.uk/covidtracker") +
          theme(
            # Remove panel border
            axis.text.y.right = element_text(colour = "red"),
            axis.title.y.right = element_text(colour = "red"),
            axis.text.y.left = element_text(colour = "purple"),
            axis.title.y.left = element_text(colour = "purple"),
            panel.border = element_blank(),  
            # Remove panel grid lines
            panel.grid.major = element_line(size = 0.5, linetype = "dashed", colour = "grey"),
            #panel.grid.minor = element_blank(),
            # Remove panel background
            panel.background = element_blank(),
            # Add axis line
            axis.line = element_line(colour = "grey"),
            plot.caption = element_text(hjust = 0.5, face = "italic"),
            plot.title = element_text(hjust = 0.5)) + 
          facet_wrap(~CountryName, ncol = 4)
        ggsave(plot = plot,
               filename = paste0("charts_" ,i, j, ".eps"),
               device = "eps",
               height = 20,
               width = 15)
        
      }else{
        countries <- unique(temp_tibble$CountryName)[33:length(unique(temp_tibble$CountryName))]
        total_countries <- length(countries)
        deficit <- 32 - total_countries
        temp_tibble <- 
          temp_tibble %>%
          filter(CountryName %in% countries)
        for(k in seq(1:deficit)){
          agg_tibble <-
            temp_tibble %>%
            ungroup() %>%
            select(CountryName, Date) %>%
            mutate(CountryName = NA) %>%
            unique() %>%
            mutate(CountryName = paste0(rep(" ", times = k), collapse = ""))
          temp_tibble <- 
            bind_rows(temp_tibble, agg_tibble)
        }
        levels <- unique(temp_tibble$CountryName)
        temp_tibble <-
          temp_tibble %>%
          mutate(country_group = factor(CountryName, levels = levels))
        plot <-
          ggplot(data = temp_tibble, aes(x = Date)) + 
          geom_line(aes(y = log10_cases), colour = "purple") +
          geom_line(aes(y = ContainmentHealthIndexForDisplay/coeff), colour = "red") +
          scale_y_continuous(name = "Reported cases",
                             breaks = seq(0, max_logcases),
                             labels = comma(do.call(rbind,lapply(seq(0, max_logcases), function(x){return(10^x)}))),
                             sec.axis = sec_axis(~.*coeff,
                                                 name = "Containment and Health Index",
                                                 breaks = c(0, 20, 40, 60, 80, 100), 
                                                 labels = c(0, 20, 40, 60, 80, 100))) + 
          expand_limits(y = c(0, max_logcases)) + 
          scale_x_date(breaks = seq.Date(from = ymd(as.Date("2020-01-01")), to = maxDate, by = "2 month"),
                       date_labels = "%d-%b") +
          labs(#title = paste0(i, "'s Covid-19 Trajectory"),
            caption = "Source: Oxford COVID-19 Government Response Tracker. More at https://github.com/OxCGRT/covid-policy-tracker 
       or bsg.ox.ac.uk/covidtracker") +
          theme(
            # Remove panel border
            axis.text.y.right = element_text(colour = "red"),
            axis.title.y.right = element_text(colour = "red"),
            axis.text.y.left = element_text(colour = "purple"),
            axis.title.y.left = element_text(colour = "purple"),
            panel.border = element_blank(),  
            # Remove panel grid lines
            panel.grid.major = element_line(size = 0.5, linetype = "dashed", colour = "grey"),
            #panel.grid.minor = element_blank(),
            # Remove panel background
            panel.background = element_blank(),
            # Add axis line
            axis.line = element_line(colour = "grey"),
            plot.caption = element_text(hjust = 0.5, face = "italic"),
            plot.title = element_text(hjust = 0.5)) + 
          facet_wrap(~country_group, ncol = 4)
        ggsave(plot = plot,
               filename = paste0("charts_" ,i, j, ".eps"),
               device = "eps",
               height = 20,
               width = 15)
      }
    }
  }
  
  
}
