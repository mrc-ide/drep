test_that("hospitalized cases calculation is correct", {

  correct_outputs <- read.table(file.path("test_data", "R0_and_burden_calculation_test.txt"), header = TRUE)

  prop_sym_parms <- c(0.45, 0.85, 0.15, 0.15)

  hosp_weights <- c(0.04, 0.1, 0.04, 0.04)

  age_band_tgs <- grep("band", names(age_structure), value = TRUE)
  age_band_bnds <- get_age_band_bounds(age_band_tgs)
  l_lim <- age_band_bnds[, 1]
  u_lim <- age_band_bnds[, 2]

  no_hosp_cases <- purrr::pmap(foi[, c("FOI", "population", "ID_0")],
                          function(FOI, population, ID_0){

                            n_j <- age_structure[which(age_structure[, "ID_0"] == ID_0), 2:ncol(age_structure)]

                            pc_hcases <- calculate_hosp_cases(FOI = FOI,
                                                 n_j = n_j,
                                                 u_lim = u_lim,
                                                 l_lim = l_lim,
                                                 parms = hosp_weights,
                                                 weights_vec = prop_sym_parms)

                            pc_hcases * population
                          })

  no_hosp_cases_vec <- unlist(no_hosp_cases)

  expect_equal(no_hosp_cases_vec, correct_outputs$hosp, tolerance = 1e-10)

})
