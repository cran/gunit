context("calculations")
library(gunit)

test_that("calculations are internally consistent", {

  g_sw1 <- units::set_units(0.001, m/s)
  g_sw2 <- convert_conductance(g_sw1)$`umol/m^2/s/Pa`
  g_sw3 <- convert_conductance(g_sw1)$`mol/m^2/s`
  expect_equal(g_sw1, convert_conductance(g_sw2)$`m/s`)
  expect_equal(g_sw1, convert_conductance(g_sw3)$`m/s`)

})
