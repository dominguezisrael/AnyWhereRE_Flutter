# anywherers_code_exercise

This project contains the code exercise for job application with Any Where Real Estate.

Please clone project and use master branch.

To launch the app in an emulator, you can either:

Run these commands in the terminal window in Android Studio:
* For 'The Wire' tv show:
flutter run --flavor thewireFlavor --dart-define=tv_show="the wire"

* For 'Simpsons' tv show:
flutter run --flavor simpsonsFlavor --dart-define=tv_show="simpsons"

or you can create a run configuration for each flavor like this:

1. Click menu "Run".
2. Select option "Edit Configurations".
3. Add a new Flutter run configuration.
4. Fill these fields:
   - In the field "Name", git it a name of your preference, like "The Wire Flavor" or "The Simpsons Flavor".
   - In the field "Dart entrypoint", specify the absolute path to the main.dart file.
   - In the field "Additional run args", specify '--flavor thewireFlavor --dart-define=tv_show="the wire"' or '--flavor simpsonsFlavor --dart-define=tv_show="simpsons"' (without outer single quotes).
