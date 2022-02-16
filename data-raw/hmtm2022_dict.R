
library(readxl)

hmtm2022_dict <- readxl::read_excel('data-raw/dict.xlsx')

# do not actually make it into a dict() this gets done by musicassessr::dict()

use_data(hmtm2022_dict, internal = TRUE, overwrite = TRUE)

