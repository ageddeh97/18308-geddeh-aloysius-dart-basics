// Student: Aloysius Geddeh
// Reg no: 18308
const String regNo = '18308';
final int d = int.parse(regNo[regNo.length - 1]);
final int t = int.parse(regNo.substring(regNo.length - 2));

int countVowels(String text) {
  // by AG
  int count = 0;
  for (final ch in text.toLowerCase().split('')) {
    if ('aeiou'.contains(ch)) count++;
  }
  return count;
}

String initials(String fullName) {
  // by AG
  final parts = fullName.trim().split(RegExp(r'\s+'));
  String result = '';
  for (final p in parts) {
    if (p.isNotEmpty) result += '${p[0].toUpperCase()}.';
  }
  return result;
}

void drawTriangle(int height) {
  // by AG
  for (int row = 1; row <= height; row++) {
    String symbol = row.isOdd ? '*' : '#';
    print(' ' * (height - row) + symbol * row);
  }
}

int momoFee(int amount) {
  // by AG
  if (amount <= 0) return -1;
  if (amount <= 1000) return 20;
  if (amount <= 10000) return 100;
  if (amount <= 150000) return 250;
  return 1500;
}

String maskPhone(String phone) {
  // by AG
  if (phone.length != 10) return 'INVALID';
  return phone.substring(0, 3) +
      '*' * (phone.length - 5) +
      phone.substring(phone.length - 2);
}

void main() {
  // by AG
  print('Reg no: $regNo | D = $d | T = $t');

  // B2
  String fullName = 'Aloysius Geddeh';
  print('$fullName has ${countVowels(fullName)} vowels');

  // B3
  print(initials(fullName));
  print(initials(' ana uwase '));
  print(initials(' '));

  // C5
  drawTriangle(d + 3);
  drawTriangle(0);
  drawTriangle(-2);

  // D2 (while loop only)
  int i = 1;
  int totalFees = 0;
  while (i <= d + 3) {
    int amount = i * 4000 + t * 100;
    int fee = momoFee(amount);
    totalFees += fee;
    print('Receipt $i | $amount RWF | fee $fee RWF | to ${maskPhone('0788123456')}');
    i++;
  }
  print('Total fees: $totalFees RWF');
}
