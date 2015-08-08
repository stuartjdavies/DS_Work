install.packages("dplyr")
install.packages("Hmisc")
install.packages("stingr")
install.packages("reshape")
install.packages("zoo")
library(dplyr)
library(stringr)
library(reshape2)
library(Hmisc)
library(zoo)

#
# Exercise 1
#
load("data/complete_data.RData")

avgReturns <- melt(SA2,id=c("Name", "Global Broad Category Group","Global Category","Morningstar Category", "MPT Benchmark"))  %>% 
                        mutate(Date = paste0(str_extract(variable, "[0-9]{4}-[0-9]{2}"), "-01") %>% as.Date) %>% 
                        select(Date, Name, value) %>% filter(!is.na(value)) %>%
                        group_by(Name) %>% summarise(`Average returns` = mean(value)) %>% collect %>% 
                        arrange(desc(`Average returns`))

#
# Exercise 2
#
invoices <- read.csv("data/invoices.csv")

monthlySales <- invoices %>%
                  mutate(`Year and month`=as.yearmon(as.POSIXlt(strptime(gsub("[A-Z]{4}", "", date), "%a %b %d %H:%M:%S %Y")), "%Y %m")) %>%
                  select(`Year and month`,total) %>%
                  group_by(`Year and month`) %>% 
                  summarise(`Total`=sum(total)) %>% 
                  collect %>% 
                  arrange(desc(`Year and month`))

dailySales <- invoices %>%
                mutate(`Year, month and day`=as.Date(as.POSIXlt(strptime(gsub("[A-Z]{4}", "", date), "%a %b %d %H:%M:%S %Y")))) %>%
                select(`Year, month and day`,total) %>%
                group_by(`Year, month and day`) %>% 
                summarise(`Total`=sum(total)) %>% 
                collect %>% 
                arrange(desc(`Year, month and day`))