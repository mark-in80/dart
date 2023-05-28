void main() {
  List<int> numbers = createList();
  //print(foobarFunction(numbers));

  var test = foobarFunction(numbers);
  print(testFunction(test));
}

List<int> createList() {
  List<int> list = [];
  for (var i = 1; list.length <= 99; i++) {
    list.add(i);
  }
  return list;
}

List<dynamic>foobarFunction(List<int> numbers) {
  var listFooBar = [];
  for (int x in numbers) {
    if (x % 3 == 0 && x % 5 != 0) {
      listFooBar.add("foo");
    }
    if (x % 5 == 0 && x % 3 != 0) {
      listFooBar.add("bar");
    }
    if (x % 5 == 0 && x % 3 == 0) {
      listFooBar.add("foobar");
    }
    if (x % 5 != 0 && x % 3 != 0) {
      listFooBar.add(x);
    }
  }
  return listFooBar;
}

String testFunction(var test) {
  assert(test[0] == 1);
  assert(test[99] == "bar");
  assert(test[14] == "foobar");
  assert(test[2] == "foo");
  return "Test Passed";
}
