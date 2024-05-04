library(tidyverse)
library(jsonlite)
cat("Darbinė direktorija:", getwd())

#------------------------------------------------------------------

download.file("https://atvira.sodra.lt/imones/downloads/2023/monthly-2023.json.zip", "../data/temp" )
unzip("../data/temp",  exdir = "../data/")
data = fromJSON('../data/monthly-2023.json')
file.remove("../data/temp")
file.remove("../data/monthly-2023.json")

#------------------------------------------------------------------------

data %>% 
  filter(ecoActCode == 494100) %>%
  saveRDS('../data/494100.rds')
