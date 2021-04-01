# flutter_riskified

> CURRENTLY UNSTABLE! Use at your own risk!

[Riskified beacon](https://support.riskified.com/hc/en-us/articles/360018066754-Mobile-SDKs-for-Native-Apps) plugin for Flutter. Currently supports iOS and Android (Swift and Kotlin).

## Usage

Start the beacon in your `main` method, before `runApp`:

```dart
import 'package:flutter_riskified/flutter_riskified.dart';
...
main() async {
    await Riskified.startBeacon("<SHOP_NAME>", "<SESSION_TOKEN>");
    ...
    runApp(MyApp());
}
```

For more, check out the example or view the [docs](https://pub.dev/documentation/flutter_riskified/latest).
