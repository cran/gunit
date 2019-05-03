context("units")
library(gunit)

test_that("wrong units fail", {

  g_sw <- units::set_units(0.001, m/s^2)
  expect_error(convert_conductance(g_sw), "object 'ret' not found")

  g_sw <- units::set_units(0.001, m/s/Pa)
  expect_error(convert_conductance(g_sw), "object 'ret' not found")

  g_sw <- units::set_units(0.001, mol/m/s)
  expect_error(convert_conductance(g_sw), "object 'ret' not found")

  g_sw <- units::set_units(0.001, m/s)
  expect_error(convert_conductance(g_sw, Temp = set_units(298.15, Pa)), "cannot convert Pa into K")
  expect_error(convert_conductance(g_sw, P = set_units(100, K)), "cannot convert K into kPa")

})
