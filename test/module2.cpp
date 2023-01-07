#include <doctest/doctest.h>
#include <module2/module2.hpp>

TEST_CASE("Test Module2") {
  SUBCASE("Subtract Positive") {
    CHECK(module2::subtract(1, 2) == -1);
    CHECK(module2::subtract(2, 3) == -1);
  }

  SUBCASE("Subtract Negative") {
    CHECK(module2::subtract(1, -2) == 3);
    CHECK(module2::subtract(2, -1) == 3);
  }
}