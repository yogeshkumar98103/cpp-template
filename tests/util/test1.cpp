#include <doctest/doctest.h>
#include <util/util.hpp>

TEST_CASE("Test Add Util") {
    SUBCASE("Add Positive") {
        CHECK(util::add(1, 2) == 3);
        CHECK(util::add(2, 3) == 5);
    }

    SUBCASE("Add Negative") {
        CHECK(util::add(1, -2) == -1);
        CHECK(util::add(2, -1) == 1);
    }
}