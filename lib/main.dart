import 'package:html/parser.dart' show parse;
import 'dart:io';

main() {
  var contentArray = [];
  new File('html/demo.html').readAsString().then((String htmlContents) {
    var document = parse(htmlContents);
    var table = document.getElementsByTagName('table');
    print(table[0].children[1].children.length);
    var rows = table[0].children[1].children;
    print(rows.length);
    for (int i = 0; i < rows.length; i++) {
      var convertedList = {};
      var row = rows[i];

      var cells = row.getElementsByTagName('td');
      if (cells[5].getElementsByTagName('table')[0].children.length > 0) {
        if (cells[5].getElementsByTagName('table')[0].children.length < 2) {
          var theoryCells = cells[5]
              .getElementsByTagName('table')[0]
              .getElementsByTagName('tr')[0]
              .getElementsByTagName('td');
          convertedList['time'] = {
            'theory': {
              "day": theoryCells[1].innerHtml,
              "start": theoryCells[2].innerHtml,
              "end": theoryCells[3].innerHtml,
              "location": theoryCells[4].innerHtml
            }
          };
        } else {
          var theoryCells = cells[5]
              .getElementsByTagName('table')[0]
              .getElementsByTagName('tr')[0]
              .getElementsByTagName('td');
          var labCells = cells[5]
              .getElementsByTagName('table')[0]
              .getElementsByTagName('tr')[1]
              .getElementsByTagName('td');
          convertedList['time'] = {
            'theory': {
              "day": theoryCells[1].innerHtml,
              "start": theoryCells[2].innerHtml,
              "end": theoryCells[3].innerHtml,
              "location": theoryCells[4].innerHtml
            },
            'lab': {
              "day": labCells[1].innerHtml,
              "start": labCells[2].innerHtml,
              "end": labCells[3].innerHtml,
              "location": labCells[4].innerHtml
            }
          };
        }
      } else {
        convertedList['time'] = {};
      }

      convertedList['classId'] = cells[0].innerHtml;
      convertedList['title'] = cells[1].innerHtml;
      convertedList['status'] = cells[2].innerHtml;
      convertedList['capcity'] = cells[3].innerHtml;
      convertedList['count'] = cells[4].innerHtml;

      contentArray.add(convertedList);
    }
  }).then((lastReturn) => {print(contentArray)});
}
