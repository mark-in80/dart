void main() {
  Marketplace marketplace =
      Marketplace("Prosrochka", 10000, "Uncle Vasia", 100500, [], []);
  marketplace.nameMarket();
  marketplace.infoOwner();
  print("\n");
  staffMethod(marketplace);
  marketplace.showStaff();
  print("\n");
  productsMethod(marketplace);
  marketplace.showProducts();
}

void staffMethod(Marketplace marketplace) {
  marketplace.staffs.add(Staff("Vasia", "Pupkin", jobTitle.cook.name, 50000));
  marketplace.staffs.add(Staff("Ivan", "Ivanov", jobTitle.admin.name, 40000));
  marketplace.staffs
      .add(Staff("Petya", "Petrov", jobTitle.cashier.name, 30000));
}

void productsMethod(Marketplace marketplace) {
  marketplace.products.add(Product(150, 0.1, "candy"));
  marketplace.products.add(Product(10, 1, "bread"));
  marketplace.products.add(Product(5, 1, "bubble"));
}

enum jobTitle { cook, admin, cashier }

extension _Marketplace on Marketplace {
  void showStaff() {
    for (Staff staff in staffs) {
      print(staff.prettyFormat);
    }
  }

  void showProducts() {
    for (Product products in products) {
      print(products.prettyFormat);
    }
  }
}

abstract class HasOwner {
  void infoOwner();
}

class Marketplace extends HasOwner {
  final String nameMarketplace;
  final proceeds;
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
  final String name;
  final String firstName;
  num salary;
  //как избавиться от зависимости этой стринги
  String jobTitle;
  final taxStaff = Tax(13);

  @override
  String toString() {
    return 'Staff{name: $name, firstName: $firstName, salary: $salary, jobTitle: $jobTitle, taxStaff: ${taxStaff.taxLikeString}}';
  }

  Staff(this.name, this.firstName, this.jobTitle, this.salary);

  double get salaryFreeTax => taxStaff.applyIncome(salary);

  @override
  String get prettyFormat =>
      "Full name: $name $firstName; job: $jobTitle; salary: $salary";
}

abstract class FormatProducts {
  String get prettyFormat;
}

class Product implements FormatStaff {
  final String category;
  final double price;
  final count;

  Product(this.price, this.count, this.category);

  @override
  // TODO: implement prettyFormat
  String get prettyFormat =>
      "Category: $category; price: $price; count: $count";
}

class Tax {
  int tax;
  Tax(this.tax);

  double taxes(int income) {
    return income * (tax / 100);
  }

  double applyIncome(num income) {
    return income * (1 - (tax / 100));
  }

  String get taxLikeString => '$tax%';
}
