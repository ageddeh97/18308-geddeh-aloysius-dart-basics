// Student: Aloysius Geddeh
// Reg no: 18308
const String regNo = '18308';
final int d = int.parse(regNo[regNo.length - 1]);
final int t = int.parse(regNo.substring(regNo.length - 2));

int momoFee(int amount) {
  // by AG
  if (amount <= 0) return -1;
  if (amount <= 1000) return 20;
  if (amount <= 10000) return 100;
  if (amount <= 150000) return 250;
  return 1500;
}

String formatRwf(int amount) {
  // by AG
  bool negative = amount < 0;
  String digits = amount.abs().toString();
  String result = '';
  int count = 0;
  int i = digits.length - 1;
  while (i >= 0) {
    result = digits[i] + result;
    count++;
    if (count % 3 == 0 && i > 0) result = ',$result';
    i--;
  }
  return '${negative ? '-' : ''}$result RWF';
}

bool isValidPin(String pin) {
  // by AG
  if (pin.length != 5) return false;
  int i = 0;
  while (i < pin.length) {
    int c = pin.codeUnitAt(i);
    if (c < 48 || c > 57) return false; // not 0-9
    i++;
  }
  if (pin == '12345') return false;
  if (pin == pin[0] * 5) return false; // same digit five times
  return true;
}

int sendMoney(int balance, int amount) {
  // by AG
  int fee = momoFee(amount);
  if (fee == -1) {
    print('Failed: invalid amount');
    return balance;
  }
  if (amount + fee > balance) {
    print('Failed: insufficient balance');
    return balance;
  }
  int newBalance = balance - amount - fee;
  print('Sent ${formatRwf(amount)} (fee ${formatRwf(fee)}). New balance: ${formatRwf(newBalance)}');
  return newBalance;
}

int buyAirtime(int balance, int amount) {
  // by AG
  if (amount < 100 || amount > 50000) {
    print('Failed: airtime must be 100 to 50,000');
    return balance;
  }
  if (amount > balance) {
    print('Failed: insufficient balance');
    return balance;
  }
  int newBalance = balance - amount;
  print('Airtime bought: ${formatRwf(amount)}. New balance: ${formatRwf(newBalance)}');
  return newBalance;
}

void main() {
  // by AG
  print('Reg no: $regNo | D = $d | T = $t');

  List<String> pins = ['12345', '77777', '4821', '48a21', '4821$d'];
  int p = 0;
  while (p < pins.length) {
    print('${pins[p]} -> ${isValidPin(pins[p])}');
    p++;
  }

  int balance = 20000 + t * 500;
  print('Starting balance: ${formatRwf(balance)}');

  int k = 0;
  while (k < 3) {
    balance = sendMoney(balance, (d + 1) * 3000);
    k++;
  }
  balance = buyAirtime(balance, 1000);
  balance = sendMoney(balance, 0);
  balance = sendMoney(balance, 200000);
  print('Final balance: ${formatRwf(balance)}');

  // My own tests (expected output in comments)
  print(formatRwf(100)); // 100 RWF
  print(formatRwf(1000000)); // 1,000,000 RWF
  print(formatRwf(-999)); // -999 RWF
  print(formatRwf(-1000)); // -1,000 RWF  <- could break: sign and comma handling
  print(isValidPin('')); // false
  print(isValidPin('00000')); // false (same digit five times)
  print(isValidPin(' 4821')); // false (space is not a digit)
  print(isValidPin('48218')); // true
}
