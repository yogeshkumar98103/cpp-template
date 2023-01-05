#pragma once

namespace lib {

struct Adder {
    int x;
    int y;

    Adder(int x, int y): x{x}, y{y} {}

    auto call() -> int;
};

} // namespace lib