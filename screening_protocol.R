library(psychTestR)
library(musicassessr)

hmtm_2022_screening <- function() {
  psychTestR::make_test(
    new_timeline(
      psychTestR::join(

        psychTestR::one_button_page(psychTestR::i18n("hmtm_hello")),

        musicassessr::select_musical_instrument_page(),

        psychTestR::conditional(test = function(state, ...) {

          language <- psychTestR::get_url_params(state)$language
          inst <- get_global("inst", state)

          if(language != "en") {
            instrument <- translate_from_dict(non_english_translation = inst, language = language)
          }
          !instrument %in% names(musicassessr::instrument_list)

        }, logic = psychTestR::join(
          psychTestR::NAFC_page(psychTestR::i18n("hmtm_student"), choices = c("Yes", "No")),
          psychTestR::text_input_page(psychTestR::i18n("hmtm_hear")),
          psychTestR::final_page(psychTestR::i18n("hmtm_thanks"))
        )),

        psychTestR::final_page(psychTestR::i18n("hmtm_not_possible"))

      ), dict = musicassessr::dict(NULL)),
    opt = test_options(
      title = "HMTM 2022 PBET Screening",
      admin_password = "ilikecheesepie432",
      languages = c("de", "en")))

}

