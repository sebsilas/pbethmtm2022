
library(readxl)

hmtm2022_dict <- readxl::read_excel('data-raw/dict.xlsx')

save(hmtm2022_dict, file = "data-raw/hmtm2022_dict.rda")
