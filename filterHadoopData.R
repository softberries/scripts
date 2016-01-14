library(dplyr)

setwd("~/Downloads")
data <- read.csv("part-00000",sep="\t", header=FALSE)

names(data) <- c("url","date","count")

data <- data %>% 
  filter(grepl("gif", url)) %>% 
  select(url, count) %>% 
  group_by(url) %>% 
  summarize(count = sum(count)) %>% 
  arrange(desc(count))

write.csv(data, file = "hadoop_output.csv",row.names=FALSE)