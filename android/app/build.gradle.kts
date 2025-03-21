plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("org.jetbrains.kotlin.android") // Updated plugin for better compatibility
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.firebase"
    compileSdk = 35 // Use the latest stable compileSdk version if possible
    ndkVersion = "27.0.12077973" // Make sure the NDK version matches your environment setup
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11" // Explicitly define the JVM target
    }

    defaultConfig {
        // Update with a unique Application ID
        applicationId = "com.example.firebase"
        // Adjust values to match your application requirements
        minSdk = 21
        targetSdk = 33 // Use the latest stable targetSdk version
        versionCode = 1 // Ensure a numeric value for versionCode
        versionName = "1.0" // Provide a string value for versionName
    }

    buildTypes {
        release {
            // Replace debug signing with a proper release key configuration for production builds
            signingConfig = signingConfigs.create("release") {
                storeFile = file("path/to/keystore.jks") // Update with the path to your keystore file
                storePassword = "your_keystore_password"
                keyAlias = "your_key_alias"
                keyPassword = "your_key_password"
            }
        }
    }
}

flutter {
    source = "../.."
}