#include <doctest/doctest.h>
#include <lib/lib.hpp>

TEST_CASE("Test Add") {
    SUBCASE("Add Positive") {
        CHECK(lib::Adder{1, 2}.call() == 3);
        CHECK(lib::Adder{2, 3}.call() == 5);
    }

    SUBCASE("Add Negative") {
        CHECK(lib::Adder{1, -2}.call() == -1);
        CHECK(lib::Adder{2, -1}.call() == 1);
    }
}