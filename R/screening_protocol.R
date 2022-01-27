hmtm_2022_screening <- function() {
  psychTestR::make_test(
    psychTestR::new_timeline(
      psychTestR::join(

        psychTestR::one_button_page(psychTestR::i18n("hmtm_hello")),

        musicassessr::select_musical_instrument_page(),

        psychTestR::conditional(test = function(state, ...) {

          language <- psychTestR::get_url_params(state)$language
          inst <- psychTestR::get_global("inst", state)
          # it already gets translated by select_musical_instrument_page
          inst %in% names(musicassessr::instrument_list)

        }, logic = psychTestR::join(
          psychTestR::NAFC_page(label = "is_student", prompt = psychTestR::i18n("hmtm_student"), choices = c(psychTestR::i18n("Yes"), psychTestR::i18n("No"))),
          psychTestR::text_input_page(label = "hear", prompt = psychTestR::i18n("hmtm_hear")),
          psychTestR::final_page(shiny::tags$p(psychTestR::i18n("hmtm_thanks"),
                                               shiny::tags$a(psychTestR::i18n("click_here"),
                                                href = "https://terminplaner4.dfn.de/qiTUczjFRHjhKR9m", target = "_blank")))

        )),

        psychTestR::final_page(psychTestR::i18n("hmtm_not_possible"))

      ), dict = musicassessr::dict(hmtm2022_dict)),
    opt = psychTestR::test_options(
      title = "HMTM 2022 PBET Screening",
      admin_password = "ilikecheesepie432",
      languages = c("de", "en")))

}

# hmtm_2022_screening()

