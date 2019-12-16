import 'dart:io';

void main() {
  new File('../html/demo.html').readAsString().then((String contents) {
    print(contents);
  });
}