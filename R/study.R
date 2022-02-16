# PBET constants
#library(renv)

# NEED TO ISOLATE AGAIN?

HMTM_Jan2022Protocol <- function(musicassessr_state = "test",
                                 SAA_length, PBET_length, SNR_test = TRUE, get_range = TRUE,
                                 examples = 2,
                                 local_app_file_dir_PBET = "/Users/sebsilas/pbethmtm2022/audio/PBET/",
                                 local_app_file_dir_SAA = "/Users/sebsilas/pbethmtm2022/audio/SAA/") {

  psychTestR::make_test(
    elts = psychTestR::join(


      psychTestR::new_timeline(
        psychTestR::join(
          psychTestR::one_button_page(shiny::tags$div(
            shiny::tags$img(src = 'https://upload.wikimedia.org/wikipedia/commons/7/78/HMTM-Logo-2010.svg'),
            shiny::tags$br(),
            shiny::tags$p(psychTestR::i18n("hmtm_welcome")))),

          psychTestR::text_input_page(label = "username", prompt = psychTestR::i18n("username"),
                                      validate = function(answer, ...) {
                                        if (answer == "")
                                          "This cannot be blank"
                                        else TRUE
                                      })

          ),
            dict = hmtm2022_dict),

      # use this instead of randomise_at_run_time because depending on the order, the SAA or PBET uses specifies different function arguments
      # musicassessr::psych_test_snap(SAA_then_PBET(SAA_length, PBET_length, SNR_test, get_range, examples),
      #                 PBET_then_SAA(SAA_length, PBET_length, SNR_test, get_range, examples),
      #                 condition1_name = "SAA_then_PBET", condition2_name = "PBET_then_SAA"),

      # NB, opting for manual counterbalancing:
      musicassessr::set_condition_page(SAA_then_PBET(SAA_length, PBET_length, SNR_test, get_range, examples, local_app_file_dir_PBET, local_app_file_dir_SAA),
                                       PBET_then_SAA(SAA_length, PBET_length, SNR_test, get_range, examples, local_app_file_dir_PBET, local_app_file_dir_SAA),
                                       condition1_name = "SAA_then_PBET", condition2_name = "PBET_then_SAA"),


      psychTestR::elt_save_results_to_disk(complete = FALSE),

      psyquest::GMS(subscales = c("General",
                                  "Abilities",
                                  "Absolute Pitch", "Instrument",
                                  "Musical Training", "Singing Abilities")),

      psyquest::DEG(),

      psyquest::SES(),

      psychTestR::new_timeline(
        psychTestR::join(
          psychTestR::elt_save_results_to_disk(complete = TRUE),

            psychTestR::final_page(shiny::tags$div(
              shiny::tags$img(src = 'https://upload.wikimedia.org/wikipedia/commons/7/78/HMTM-Logo-2010.svg'),
              shiny::tags$br(),
              shiny::tags$p(psychTestR::i18n("hmtm_finish"))))
        ), dict = hmtm2022_dict)
    ),


    opt = psychTestR::test_options(title = "HMTM 2022",
                                   admin_password = "ilikecheesepie432",
                                   enable_admin_panel = FALSE,
                                   display = psychTestR::display_options(
                                     left_margin = 1L,
                                     right_margin = 1L,
                                     css = system.file('www/css/musicassessr.css', package = "musicassessr")
                                   ),
                                   additional_scripts = musicassessr::musicassessr_js(musicassessr_state, visual_notation = TRUE),
                                   languages = c("en", "de"))
  )

}


SAA_then_PBET <- function(SAA_length, PBET_length, SNR_test, get_range, examples = 2, local_app_file_dir_PBET, local_app_file_dir_SAA) {

  psychTestR::join(

    psychTestR::new_timeline(psychTestR::one_button_page(psychTestR::i18n("hmtm_intro_text1")), dict = hmtm2022_dict),

    SAA::SAA(num_items = SAA_length,
             musicassessr_state = musicassessr_state,
             SNR_test = SNR_test, get_range = get_range,
             with_final_page = FALSE,
             absolute_url = "https://adaptiveeartraining.com/SAA",
             examples = examples,
             show_socials = FALSE,
             demographics = FALSE,
             gold_msi = FALSE,
             copy_audio_to_location = local_app_file_dir_SAA),

    PBET::PBET(num_items = PBET_length,
               musicassessr_state = musicassessr_state,
               SNR_test = FALSE,
               get_range = TRUE,
               feedback = FALSE,
               final_results = TRUE,
               max_goes_forced = TRUE,
               max_goes = 2L,
               give_first_melody_note = TRUE,
               with_final_page = FALSE,
               show_socials = FALSE,
               demographics = FALSE,
               gold_msi = FALSE,
               headphones_test = FALSE,
               get_user_info = FALSE,
               copy_audio_to_location = local_app_file_dir_PBET)


  )
}

PBET_then_SAA <- function(SAA_length, PBET_length, SNR_test = TRUE, get_range = TRUE, examples = 2, local_app_file_dir_PBET, local_app_file_dir_SAA) {

  psychTestR::join(

    psychTestR::new_timeline(psychTestR::one_button_page(psychTestR::i18n("hmtm_intro_text2")), dict = hmtm2022_dict),

    PBET::PBET(num_items = PBET_length,
               musicassessr_state = musicassessr_state,
               SNR_test = SNR_test, get_range = get_range,
               feedback = FALSE,
               final_results = TRUE,
               max_goes_forced = TRUE,
               max_goes = 2L,
               give_first_melody_note = TRUE,
               with_final_page = FALSE,
               demographics = FALSE,
               show_socials = FALSE,
               gold_msi = FALSE,
               copy_audio_to_location = local_app_file_dir_PBET),

    SAA::SAA(num_items = SAA_length,
             musicassessr_state = musicassessr_state,
             SNR_test = FALSE, get_range = TRUE,
             with_final_page = FALSE,
             absolute_url = "https://adaptiveeartraining.com/SAA",
             demographics = FALSE,
             gold_msi = FALSE,
             headphones_test = FALSE,
             get_user_info = FALSE,
             copy_audio_to_location = local_app_file_dir_SAA)

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
                                          "wjd_audio" = list("key_easy" = 0L, "key_hard" = 0L)),
                       SNR_test = FALSE, get_range = FALSE,  examples = 0)
}


demographics_only <- function() {

  psychTestR::make_test(
    psychTestR::join(
    psyquest::GMS(subscales = c("General",
                                "Abilities",
                                "Absolute Pitch", "Instrument",
                                "Musical Training", "Singing Abilities")),

    psyquest::DEG(),

    psyquest::SES(),

    psychTestR::new_timeline(
      psychTestR::join(
        psychTestR::elt_save_results_to_disk(complete = TRUE),

        psychTestR::final_page(shiny::tags$div(
          shiny::tags$img(src = 'https://upload.wikimedia.org/wikipedia/commons/7/78/HMTM-Logo-2010.svg'),
          shiny::tags$br(),
          shiny::tags$p(psychTestR::i18n("hmtm_finish"))))))
    ))
}

# hmtm_quick()
# hmtm_full()

# for leaderboard to work...

# setwd('test_apps/PBET_2022')
# shiny::runApp(".")
