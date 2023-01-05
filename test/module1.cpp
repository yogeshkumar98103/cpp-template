#include <doctest/doctest.h>
#include <module1/module1.hpp>

TEST_CASE("Test Module1") {
  SUBCASE("Add Positive") {
    CHECK(module1::Adder{1, 2}.call() == 3);
    CHECK(module1::Adder{2, 3}.call() == 5);
  }

  SUBCASE("Add Negative") {
    CHECK(module1::Adder{1, -2}.call() == -1);
    CHECK(module1::Adder{2, -1}.call() == 1);
  }
}