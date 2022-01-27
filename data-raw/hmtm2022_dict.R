
library(readxl)

hmtm2022_dict <- readxl::read_excel('data-raw/dict.xlsx')

use_data(hmtm2022_dict, internal = TRUE)
