# Add firebase to flutter application

To add firebase to flutter application follow the below steps:- 

 - Create flutter project
	 - `flutter create <project_name>`
 - Link flutter project to firebase
	 - Install firebase CLI
		 - `npm install -g firebase-tools`
		 - `dart pub global activate flutterfire_cli`
	 - Run command `flutterfire configure`
	 - Follow the default steps

# Link flutter application to local firebase emulator
To link flutter app to local firebase emulator follow below steps:-
## Configure Emulator
 - Run command `firebase init`
 - Follow default. steps and choose firebase auth and firestore in emulators.
 - Start emulator using command
	 - `firebase emulators:start`
 - Start emulator while not loosing history
	 - `firebase emulators:start --import=./firestore_import --export-on-exit`
## Link flutter application to emulator
To link flutter application. to emulator use below code. Point to note :- Replace ipAddress with your machine IpAddress.

	
  

    const bool useEmulator = false;
    const bool usePhysicalDevice = false;
    const bool useWeb = false;
    const String ipAddress = "192.168.1.2";
    void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    );
    if (useEmulator) {
	    if (usePhysicalDevice) {
	    String host = defaultTargetPlatform == TargetPlatform.android
	    ? '$ipAddress:8080' 
	    : 'localhost:8080';
	    FirebaseFirestore.instance.settings = Settings(host: host, sslEnabled: false);
	    FirebaseFirestore.instance.useFirestoreEmulator(host.split(':')[0], 8080);
	    await FirebaseAuth.instance.useAuthEmulator(host.split(':')[0], 9099);
	    } else {
	    String host = defaultTargetPlatform == TargetPlatform.android
	    ? '10.0.2.2:8080'
	    : 'localhost:8080';
	    if (useWeb) {
	    FirebaseFirestore.instance.useFirestoreEmulator("localhost", 8080);
	    } else {
	    FirebaseFirestore.instance.settings =
	    Settings(host: host, sslEnabled: false);
	    }
	    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
	    }
    }

Now add  below lines to android/app/src/debug/AndroidManifest.xml in the manifest tag.
	
    <application  android:usesCleartextTraffic="true"/>

Boom now your application is ready and linked with firebase.

## Test changes

 - Enable annonymous authentiication in firestore project.
 -  Enable firestore. database.
 - Enable blaze plan
 - Run the github code. You can see annonymous. logging working.
