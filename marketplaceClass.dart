import 'dart:io';

void main() {
  Marketplace marketplace =
      Marketplace("Prosrochka", 10000, "Uncle Vasia", 100500, [], []);
  Product product = Product(0, 0, "_category");
  product.addNewProduct(marketplace);
  marketplace.showProducts();
}

void staffMethod(Marketplace marketplace) {
  marketplace.staffs.add(Staff("Ivan", "Ivanov", _JobTitle.admin, 40000));
  marketplace.staffs.add(Staff("Petya", "Petrov", _JobTitle.cashier, 30000));
  marketplace.staffs.add(Staff("Vova", "Sidorov", _JobTitle.cook, 35000));

}

void productsMethod(Marketplace marketplace) {
  marketplace.products.add(Product(150, 0.1, "candy"));
  marketplace.products.add(Product(10, 1, "bread"));
  marketplace.products.add(Product(5, 1, "bubble"));
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

  void hireNewStaff() {}
}

abstract class FormatProducts {
  String get productsFormat;
}

class Product<T> implements FormatProducts {
  final T _nameProduct;
  final T _price;
  final T _count;

  Product(this._price, this._count, this._nameProduct);

  @override
  String get productsFormat =>
      "Category: $_nameProduct; price: $_price; count: $_count";

  void addNewProduct(Marketplace marketplace) {
    var abstractVariable = " ";

    while (abstractVariable != "break") {
      stdout.write("Enter  Name products,  or Enter break for stop: ");
      try {
        T nameProduct = stdin.readLineSync() as T;
        if (nameProduct == "break") {
          break;
        }
        stdout.write("Enter  Price,  or Enter break for stop: ");
        T priceProduct = stdin.readLineSync() as T;
        if (priceProduct == "break") {
          break;
        }
        stdout.write("Enter  Count,  or Enter break for stop: ");
        T countProduct = stdin.readLineSync() as T;
        if (countProduct == "break") {
          break;
        } else {
          marketplace.products
              .add(Product(priceProduct, countProduct, nameProduct));
        }
      } catch (exception) {
        print(exception);
      }
    }
  }
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
