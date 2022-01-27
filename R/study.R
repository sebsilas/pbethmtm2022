# PBET constants


HMTM_Jan2022Protocol <- function(musicassessr_state = "test", SAA_length, PBET_length) {

  psychTestR::make_test(
    elts = psychTestR::join(

      HMTM_Jan2022Protocol_study_intro(),

      # use this instead of randomise_at_run_time because depending on the order, the SAA or PBET uses specifies different function arguments
      musicassessr::psych_test_snap(SAA_then_PBET(SAA_length, PBET_length),
                      PBET_then_SAA(SAA_length, PBET_length)),

      psychTestR::final_page("You have finished the study, thank you very much!")),

    opt = psychTestR::test_options(title = "Playing By Ear HMTM",
                                   admin_password = "ilikecheesepie432",
                                   enable_admin_panel = FALSE,
                                   display = psychTestR::display_options(
                                     left_margin = 1L,
                                     right_margin = 1L,
                                     css = system.file('www/css/musicassessr.css', package = "musicassessr")
                                   ),
                                   additional_scripts = musicassessr_js(musicassessr_state, visual_notation = TRUE),
                                   languages = c("en", "de"))
  )

}


SAA_then_PBET <- function(SAA_length, PBET_length) {
  psychTestR::join(

    SAA::SAA(num_items = SAA_length,
             musicassessr_state = musicassessr_state,
             SNR_test = TRUE, get_range = TRUE,
             with_final_page = FALSE,
             absolute_url = "https://adaptiveeartraining.com/SAA"),

    PBET::PBET(num_items = PBET_length,
               musicassessr_state = musicassessr_state,
               SNR_test = FALSE, get_range = TRUE,
               feedback = FALSE,
               final_results = TRUE,
               max_goes_forced = TRUE,
               max_goes = 1L,
               give_first_melody_note = TRUE,
               melody_length = 3:4,
               with_final_page = FALSE)
  )
}

PBET_then_SAA <- function(SAA_length, PBET_length) {
  psychTestR::join(

    PBET::PBET(num_items = PBET_length,
               musicassessr_state = musicassessr_state,
               SNR_test = TRUE, get_range = TRUE,
               feedback = FALSE,
               final_results = TRUE,
               max_goes_forced = TRUE,
               max_goes = 1L,
               give_first_melody_note = TRUE,
               melody_length = 3:4,
               with_final_page = FALSE),

    SAA::SAA(num_items = SAA_length,
             musicassessr_state = musicassessr_state,
             SNR_test = FALSE, get_range = TRUE,
             with_final_page = FALSE,
             absolute_url = "https://adaptiveeartraining.com/SAA")

  )
}

HMTM_Jan2022Protocol_study_intro <- function() {
  psychTestR::join(
    psychTestR::one_button_page("Welcome to HMTM's new Playing By Ear Study!")
  )
}


hmtm_full <- function() {

  HMTM_Jan2022Protocol(SAA_length = list("long_tones" = 6L,
                                         "arrhythmic" = 10L,
                                         "rhythmic" = 10L),
                       PBET_length = list("interval_perception" = 0L,
                                          "find_this_note" = 0L,
                                          "arrhythmic" = list("key_easy" = 10L, "key_hard" = 10L),
                                          "rhythmic" = list("key_easy" = 10L, "key_hard" = 10L),
                                          "wjd_audio" = list("key_easy" = 0L, "key_hard" = 0L)))
}

hmtm_quick <- function() {

  HMTM_Jan2022Protocol(SAA_length = list("long_tones" = 2L,
                                         "arrhythmic" = 2L,
                                         "rhythmic" = 2L),
                       PBET_length = list("interval_perception" = 0L,
                                          "find_this_note" = 0L,
                                          "arrhythmic" = list("key_easy" = 1L, "key_hard" = 1L),
                                          "rhythmic" = list("key_easy" = 1L, "key_hard" = 1L),
                                          "wjd_audio" = list("key_easy" = 0L, "key_hard" = 0L)))
}



#hmtm_quick()

# for leaderboard to work...

# setwd('test_apps/PBET_2022')
# shiny::runApp(".")
