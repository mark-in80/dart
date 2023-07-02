import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  Marketplace marketplace =
      Marketplace("Prosrochka", 10000, "Uncle Vasia", 100500, [], []);
  productsCreateInfo(marketplace);

  await marketplace.saveStaff();

  marketplace.saveProductJson();
}

void staffCreateInfo(Marketplace marketplace) {
  marketplace.staffs.add(Staff("Ivan", "Ivanov", _JobTitle.admin, 40000));
  marketplace.staffs.add(Staff("Petya", "Petrov", _JobTitle.cashier, 30000));
  marketplace.staffs.add(Staff("Vova", "Sidorov", _JobTitle.cook, 35000));
}

void productsCreateInfo(Marketplace marketplace) {
  marketplace.products.add(Product(150, 0.1, "candy"));
  marketplace.products.add(Product(10, 1, "bread"));
  marketplace.products.add(Product(5, 1, "bubble"));
}

void addNewProduct(Marketplace marketplace) {
  while (true) {
    stdout.write("Enter  Name products,  or Enter break for stop: ");
    try {
      final String nameProduct = stdin.readLineSync() ?? '0';
      if (nameProduct == "break") {
        break;
      }

      stdout.write("Enter  Price,  or Enter break for stop: ");
      String checkPriceProduct = stdin.readLineSync() ?? '0';
      if (checkPriceProduct == "break") {
        break;
      }
      double priceProduct = double.parse(checkPriceProduct);

      stdout.write("Enter  Count,  or Enter break for stop: ");
      String checkCountProduct = stdin.readLineSync() ?? '0';
      if (checkCountProduct == "break") {
        break;
      } else {
        double countProduct = double.parse(checkCountProduct);
        marketplace.products
            .add(Product(priceProduct, countProduct, nameProduct));
      }
    } catch (exception) {
      print(exception);
    }
  }
}

void addNewStaff(Marketplace marketplace) {
  while (true) {
    stdout.write("Enter  Name ,  or Enter break for stop: ");
    try {
      final String name = stdin.readLineSync() ?? '0';
      if (name == "break") {
        break;
      }

      stdout.write("Enter  First Name staff,  or Enter break for stop: ");
      String firstName = stdin.readLineSync() ?? '0';
      if (firstName == "break") {
        break;
      }

      stdout.write("Enter  job staff,  or Enter break for stop: ");
      dynamic jobTitle = stdin.readLineSync() ?? '0';
      if (jobTitle == "break") {
        break;
      }

      var enumJobTitle = stringToEnum(jobTitle);

      stdout.write("Enter  salary,  or Enter break for stop: ");
      String checkSalaryStaff = stdin.readLineSync() ?? '0';
      if (checkSalaryStaff == "break") {
        break;
      }
      num salaryStaff = double.parse(checkSalaryStaff);

      marketplace.staffs.add(Staff(name, firstName, enumJobTitle, salaryStaff));
    } catch (exception) {
      print(exception);
    }
  }
}

_JobTitle stringToEnum(String jobTitle) {
  return _JobTitle.values
      .firstWhere((element) => element.name == jobTitle, orElse: null);
}

enum _JobTitle { cook, admin, cashier }

extension _Marketplace on Marketplace {
  void showStaff() {
    for (Staff staff in staffs) {
      print(staff.prettyFormat);
    }
  }

  void showProducts() {
    for (Product products in products) {
      print(products.productsFormat);
    }
  }

  String writeProductsFile() {
    var listProductFile = "";
    for (Product products in products) {
      listProductFile = products.productsFormat + "\n" + listProductFile;
    }
    return listProductFile;
  }

  String writeStaffFile() {
    var listStaffFile = "";
    for (Staff staff in staffs) {
      listStaffFile = staff.prettyFormat + "\n" + listStaffFile;
    }
    return listStaffFile;
  }

  String writeProductsFileJson() {
    var listProductFilJson = "";
    for (Product products in products) {
      listProductFilJson = products.productsFormat + " " + listProductFilJson;
    }
    return listProductFilJson;
  }
}

abstract class HasOwner {
  void infoOwner();
}

class Marketplace extends HasOwner {
  final String nameMarketplace;
  final int proceeds;
  final String nameOwner;
  final int salaryOwner;
  final List<Staff> staffs;
  final List<Product> products;

  Marketplace(this.nameMarketplace, this.proceeds, this.nameOwner,
      this.salaryOwner, this.staffs, this.products);

  void nameMarket() {
    print("Name marketplace is $nameMarketplace");
  }

  void infoOwner() {
    print(
        "Owner marketplace is $nameOwner, his salary is $salaryOwner parrots");
  }

  Future<void> saveProducts() async {
    final File fileProducts = File('listProducts.txt');
    await fileProducts.writeAsString(writeProductsFile());
  }

  Future<void> saveStaff() async {
    final File fileStaff = File('listStaff.txt');
    await fileStaff.writeAsString(writeStaffFile());
  }

  Future<void> saveProductJson() async {
    var encoded = json.encode(writeProductsFileJson());
    final File fileProductsJson = File('listProductsJSON.json');
    await fileProductsJson.writeAsString(encoded);
  }
}

abstract class FormatStaff {
  String get prettyFormat;
}

class Staff implements FormatStaff {
  final String _name;
  final String _firstName;
  final num _salary;
  _JobTitle _jobTitle;

  final taxStaff = Tax(13);

  @override
  String toString() {
    return 'Staff{name: $_name, firstName: $_firstName, salary: $_salary, jobTitle: ${_jobTitle.name}, taxStaff: ${taxStaff.taxLikeString}}';
  }

  Staff(this._name, this._firstName, this._jobTitle, this._salary);

  double get salaryFreeTax => taxStaff.applyIncome(_salary);

  String get prettyFormat =>
      "Full name: $_name $_firstName; job: ${_jobTitle.name}; salary: $_salary";
}

abstract class FormatProducts {
  String get productsFormat;
}

class Product implements FormatProducts {
  final String _nameProduct;
  final double _price;
  final double _count;

  Product(this._price, this._count, this._nameProduct);

  @override
  String get productsFormat =>
      "Category: $_nameProduct; price: $_price; count: $_count";
}

class Tax {
  final int tax;
  Tax(this.tax);

  double taxes(int income) {
    return income * (tax / 100);
  }

  double applyIncome(num income) {
    return income * (1 - (tax / 100));
  }

  String get taxLikeString => '$tax%';
}
