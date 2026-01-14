plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.laptop_harbor"
    
    // ✅ SDK versions - IMPORTANT: compileSdk sirf ek baar define karo
    compileSdk = 36  // Latest SDK
    
    // ✅ NDK version
    ndkVersion = "27.0.12077973"
    
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17  // ✅ 11 se 17 karo
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"  // ✅ 11 se 17 karo
    }

    defaultConfig {
        // ✅ Pehle ndk block rakhna chahiye
        ndk {
            abiFilters.addAll(listOf("armeabi-v7a", "arm64-v8a", "x86", "x86_64"))
        }
        
        // TODO: Specify your own unique Application ID
        applicationId = "com.example.laptop_harbor"
        
        // Flutter values use karo
        minSdk = flutter.minSdkVersion  // ✅ Direct 21 rakho ya flutter.minSdkVersion
        targetSdk = 36  // ✅ Latest SDK
        
        versionCode = 1  // ✅ Direct value ya flutter.versionCode
        versionName = "1.0"  // ✅ Direct value ya flutter.versionName
    }

    buildTypes {
        release {
            // ✅ Release optimization - pehle disable rakho
            isMinifyEnabled = false
            isShrinkResources = false
            
            // TODO: Add your own signing config for the release build.
            signingConfig = signingConfigs.getByName("debug")
            
            // ✅ Proguard rules add karo
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // ✅ Add basic dependencies
    implementation("androidx.core:core-ktx:1.12.0")
}
