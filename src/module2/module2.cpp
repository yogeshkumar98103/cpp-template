#include <module1/module1.hpp>

namespace module2 {

int subtract(int x, int y) {
  return module1::add(x, -y);
}

} // namespace module2