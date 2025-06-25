import 'dart:io';

final List<String> manu = [
  '\n셔츠: 45000원\n'
      '원피스: 30000원\n'
      '반팔티: 35000원\n'
      '반바지: 38000원\n'
      '양말: 5000원\n',
];

final Map<String, int> productPrice = {
  '셔츠': 45000,
  '원피스': 30000,
  '반팔티': 35000,
  '반바지': 38000,
  '양말': 5000,
};

final Map<String, int> cart = {};

void main() {
  while (true) {
    print('\n[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 총 가격 보기 / [4] 종료');
    stdout.write('번호 입력: ');
    var input = stdin.readLineSync();

    switch (input) {
      case '1':
        viewItems();
        break;
      case '2':
        addToCart();
        break;
      case '3':
        viewCartTotal();
        break;
      case '4':
        print('안녕히 가세요!');
        return;
      default:
        print('잘못된 입력입니다.');
    }
  }
}

void viewItems() {
  print('\n상품 목록:');
  print(manu);
}

void addToCart() {
  stdout.write('\n상품 이름을 입력해 주세요: ');
  String? name = stdin.readLineSync();

  if (name == null || !productPrice.containsKey(name)) {
    print('존재하지 않는 상품입니다.');
    return;
  }

  stdout.write('상품 개수를 입력해 주세요: ');
  int? quantity = int.tryParse(stdin.readLineSync() ?? '');

  if (quantity == null || quantity <= 0) {
    print('0개보다 많은 수량만 가능합니다.');
    return;
  }

  cart[name] = (cart[name] ?? 0) + quantity;
  print('장바구니에 담겼습니다.');
}

void viewCartTotal() {
  int total = 0;
  cart.forEach((item, qty) {
    total += productPrice[item]! * qty;
  });
  print('총합: ${total}원입니다!');
}
