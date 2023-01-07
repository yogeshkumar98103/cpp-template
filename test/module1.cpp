#include <doctest/doctest.h>
#include <module1/module1.hpp>

TEST_CASE("Test Module1") {
  SUBCASE("Add Positive") {
    CHECK(module1::add(1, 2) == 3);
    CHECK(module1::add(2, 3) == 5);
  }

  SUBCASE("Add Negative") {
    CHECK(module1::add(0, -1) == -1);
    CHECK(module1::add(3, -2) == 1);
  }
}