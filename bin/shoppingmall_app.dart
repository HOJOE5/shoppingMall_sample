import 'dart:io';

class ShoppingmallApp {
  final List<String> productName = ['셔츠', '원피스', '반팔티', '반바지', '양말'];
  final List<int> productPrice = [45000, 30000, 35000, 38000, 5000];

  // 장바구니는 상품명과 수량만 기록
  final List<String> cartName = [];
  final List<int> cartQuantity = [];

  /* Map이 아닌 과제는 List를 원함
  final Map<String, int> productNamePrice = {
    '셔츠': 45000,
    '원피스': 30000,
    '반팔티': 35000,
    '반바지': 38000,
    '양말': 5000,
  };

  final Map<String, int> cart = {};
*/

  void showProducts() {
    print('\n상품 목록:');
    for (var i = 0; i < productName.length; i++) {
      print('${productName[i]} / ${productPrice[i]}원');
    }
  }

  void addToCart() {
    try {
      stdout.write('\n상품 이름을 입력해 주세요: ');
      String? name = stdin.readLineSync();

      if (name == null || !productName.contains(name)) {
        print('존재하지 않는 상품입니다.');
        return;
      }

      stdout.write('상품 개수를 입력해 주세요: ');
      String? input = stdin.readLineSync(); // 해당코드는 String만 사용함
      int quantity = int.parse(input!); // 입력이 null이거나 숫자 아님 → 예외 발생

      if (quantity <= 0) {
        print('0개보다 많은 수량만 가능합니다.');
        return;
      }

      if (cartName.contains(name)) {
        int index = cartName.indexOf(name);
        print('$name는 리스트의 $index 번호입니다.'); // 번호가 제대로 출력되는지 확인
        cartQuantity[index] += quantity;
      } else {
        cartName.add(name);
        cartQuantity.add(quantity);
      }

      print('장바구니에 담겼습니다.');
    } catch (e) {
      print('오류 발생: $e');
    }
  }

  void showTotal() {
    int total = 0;
    for (int i = 0; i < cartName.length; i++) {
      String item = cartName[i];
      int quantity = cartQuantity[i];
      int price = productPrice[productName.indexOf(item)];
      total += price * quantity;
    }
    print('총합: ${total}원입니다!');
  }

  // 장바구니 비우기 여부 추가
  void removeAllitems() {
    stdout.write('\n장바구니를 비우겠습니까? (Y/N) ');
    String? inputCart = stdin.readLineSync();

    if (inputCart != null && inputCart.toUpperCase() == 'Y') {
      cartName.clear();
      cartQuantity.clear();
      print('\n장바구니를 비웠습니다.');
      return;
    }
  }
}

void main() {
  ShoppingmallApp shoppingmallApp = ShoppingmallApp();
  bool isLoggedIn = true;
  if (isLoggedIn) {
    print('환영합니다, 사용자님');
    while (isLoggedIn) {
      print(
        '\n[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 총 가격 보기 / [4] 종료 / [6] 장바구니 비우기',
      );
      stdout.write('번호 입력: ');
      var input = stdin.readLineSync();

      switch (input) {
        case '1':
          shoppingmallApp.showProducts();
          break;
        case '2':
          shoppingmallApp.addToCart();
          break;
        case '3':
          shoppingmallApp.showTotal();
          break;
        case '4':
          print('\n정말로 종료하시겠습니까? \n[5번] 누르면 진짜 종료');
          stdout.write('번호 입력: ');
          var inputClose = stdin.readLineSync();
          int closeNumber = int.parse(inputClose!);
          if (closeNumber == 5) {
            print('\n이용해주셔서 감사합니다.');
            print('\n안녕히가세요');
            isLoggedIn = false;
            break;
          } else {
            print('종료하지 않습니다.');
            break;
          }

        case '6':
          shoppingmallApp.removeAllitems();
          break;

        default:
          print('잘못된 입력입니다.');
      }
    }
  }
}
