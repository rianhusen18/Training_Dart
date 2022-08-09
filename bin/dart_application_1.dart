import 'dart:io';

void main(List<String> arguments) {
  bool isLogin = login();
  if (isLogin) {
    home();
  }
}

class User {
  final String username;
  final String password;
  int balance;

  User(
    this.username,
    this.password,
    this.balance,
  );
}

List<User> listUser = <User>[
  User('u01', '001', 10),
  User('u02', '002', 50),
  User('u03', 'u003', 25)
];

User? currentUser;

bool login() {
  stdout.write('\nUsername : ');
  String username = stdin.readLineSync() ?? '';
  for (User user in listUser) {
    if (user.username == username) {
      currentUser = user;
      break;
    }
  }
  if (currentUser == null) {
    stdout.writeln('User Name Not Found');
    return false;
  }
  stdout.write('\nPassword : ');
  String password = stdin.readLineSync() ?? '';
  if (currentUser!.password != password) {
    stdout.writeln('Password Salah');
    currentUser = null;
    return false;
  }
  stdout.writeln('Welcome, $username!');
  return true;
}

void home() {
  stdout.writeln('Menu:');
  stdout.writeln('1. Cek Saldo');
  stdout.writeln('2. Tarik Tunai');
  stdout.writeln('3. Setor Tunai');
  stdout.writeln('4. Transfer');
  stdout.writeln('5. Ganti Akun');
  stdout.writeln('6. Keluar');
  stdout.write('Pilih Menu [1-6]:');
  String menu = stdin.readLineSync() ?? '';
  switch (menu) {
    case '1':
      balaceCheck();
      home();
      break;
    case '2':
      cashWithdrawal();
      balaceCheck();
      break;
    case '3':
      cashDeposit();
      balaceCheck();
      break;
    case '4':
      balanceTransfer();
      balaceCheck();
      break;
    case '5':
      currentUser = null;
      bool isLogin = login();
      if (isLogin) login();
      break;
    case '6':
      break;
    default:
      exit(0);
  }
}

void balaceCheck() {
  stdout.writeln('Saldo Anda Saat ini, ');
  stdout.writeln('\$${currentUser!.balance}');
}

void cashWithdrawal() {
  stdout.write('Nominal Penarikan : ');
  String strAmount = stdin.readLineSync() ?? '0';
  int amount = int.tryParse(strAmount) ?? 0;
  if (amount > currentUser!.balance) {
    stdout.writeln('saldo tidak cukup ');
    return;
  }

  for (User user in listUser) {
    if (user.username == currentUser!.username) {
      user.balance = user.balance - amount;
      break;
    }
  }
}

void cashDeposit() {
  stdout.write('Nominal Setor Tunai : ');
  String strAmount = stdin.readLineSync() ?? '0';
  int amount = int.tryParse(strAmount) ?? 0;
  for (User user in listUser) {
    if (user.username == currentUser!.username) {
      user.balance += amount;
      break;
    }
  }
}

void balanceTransfer() {
  stdout.write('Akun Tujuan : ');
  String username = stdin.readLineSync() ?? '';
  User? userTarget;
  for (User user in listUser) {
    if (user.username == username) {
      userTarget = user;
      break;
    }
  }
  if (userTarget == null) {
    stdout.writeln('Pengguna Tidak Ditemukan');
    return;
  }

  stdout.write('Nominal Transfer: ');
  String strAmount = stdin.readLineSync() ?? '0';
  int amount = int.tryParse(strAmount) ?? 0;
  if (amount > currentUser!.balance) {
    stdout.writeln('saldo tidak cukup ');
    return;
  }
  for (User user in listUser) {
    if (user.username == currentUser!.username) {
      user.balance -= amount;
    }
    if (user.username == userTarget.username) {
      user.balance += amount;
    }
  }
}
