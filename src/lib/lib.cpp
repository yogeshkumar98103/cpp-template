#include <lib/lib.hpp>
#include <util/util.hpp>

namespace lib {

auto Adder::call() -> int {
    return util::add(x, y);
}

} // namespace lib