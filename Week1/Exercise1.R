install.packages(plyr)
  install.packages(Hmisc)
library(plyr)
library(stringr)
library(reshape2)
library(Hmisc)

load("data/complete_data.RData")

SA2.m[complete.cases(SA2.m$value)]

xs <- melt(SA2,id=c("Name", "Global Broad Category Group","Global Category","Morningstar Category", "MPT Benchmark"))
  
xs <- xs > mutate(Year.mon = str_extract(variable, "[0-9]{4}[.][0-9]{2}"),
                          Yearmon = gsub("[.]", "-", Year.mon),
                          Yearmonday = paste0(Yearmon, "-01"),
                          Date = as.Date(Yearmonday)) > select(Date, Name, value)

mutate(xs,  mutate(Year.mon = str_extract(variable, "[0-9]{4}[.][0-9]{2}"),
                   Yearmon = gsub("[.]", "-", Year.mon),
                   Yearmonday = paste0(Yearmon, "-01"),
                   Date = as.Date(Yearmonday)) %>%
         select(Date, Name, value)
       
SA2 %>% group_by(name)
