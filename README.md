# Ofx

This package converts the string from an ofx (Open Financial Exchange) file into a class.

## Initialization

Import `package:ofx/ofx.dart` library.

[`Ofx`] can be called as follows.

```dart
import 'package:ofx/ofx.dart';

Future<void> main() {
   File('file.ofx').readAsString().then((String contents) {
      print( Ofx.fromString(contents) );
   });
}
```

#### Convert DateTimes between time zones

The conversion to class already converts the `DateTime` fields to the local time zone.

```dart
var ofx = Ofx.fromString('');
ofx.serverLocal;
ofx.startLocal;
ofx.endLocal;

ofx.transactions[index].postedLocal;
```