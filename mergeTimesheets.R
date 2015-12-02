##
## 1. Install dplyr and gdata if not already installed with
## 'install.packages(..)' command
##
## 2. Load the script into R with 'source('~/Desktop/mergeTimesheets.R')' command.
##
library(dplyr)
library(gdata)

## Set the current working directory to the one where all the timesheets are loaded
setwd("~/Downloads/timesheets/")

## Set the name for the final file
resultFile <- "result.xls"
## If it exists, remove it
if (file.exists(resultFile)) file.remove(resultFile)

## Remove the dataset object from the current context if it already exists.
if(exists("dataset")){
  rm("dataset")
}

## Load all the files with *.xls extension into a single data.frame
file_list <- list.files()
for (file in file_list){
  # if the merged dataset doesn't exist, create it
  if (!exists("dataset")){
    dataset <- read.xls (file, sheet = 1, header = TRUE)
  }else {
    temp_dataset <- read.xls (file, sheet = 1, header = TRUE)
    dataset<- merge(dataset, temp_dataset, all.x = TRUE, all.y = TRUE)
    rm(temp_dataset)
  }
}

## Select only the important columns
res <- select(dataset, Work.date, Issue.summary, Full.name, Hours)
## Format the date to save only year/month/day
res <- mutate(res, Work.date = as.character(as.Date(ymd_hm(Work.date), format="YYYY/mm/dd")))
## Rename the columns
names(res) <- c("Date", "Work", "Consultant", "Hours")
## Change the date '-' dashes to '/' slashes
res <- mutate(res, Date = gsub("-","/",Date))

## Save the data frame to a file
write.xlsx(res, resultFile, row.names=FALSE)
