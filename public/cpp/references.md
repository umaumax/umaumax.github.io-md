# cpp references

## `&`付きの型に対して，自由に値を代入したい

* [C\+\+ \- 参照の初期化を条件分岐で行う方法について｜teratail]( https://teratail.com/questions/158884 )
* [std::vector で参照を保持したい \- Secret Garden\(Instrumental\)]( http://secret-garden.hatenablog.com/entry/2015/08/28/000000 )

```
#include <functional>
#include <iostream>
#include <string>
#include <vector>

void print_first_one(const std::vector<std::string>& vec) {
  std::cout << vec[0] << std::endl;
}

int main(int argc, char* argv[]) {
  std::vector<std::string> a = {"alice"};
  std::vector<std::string> b = {"bob"};

  std::reference_wrapper<std::vector<std::string>> target_ref = a;

  std::cout << target_ref.get()[0] << std::endl;
  print_first_one(target_ref);

  target_ref = b;

  std::cout << target_ref.get()[0] << std::endl;
  print_first_one(target_ref);
  return 0;
}
```
