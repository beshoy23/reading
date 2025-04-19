plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.readingapp222.flutterapp"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.readingapp222.flutterapp"

        // ✅ Dynamic versionCode from Codemagic or fallback to 1
        versionCode = System.getenv("BUILD_NUMBER")?.toInt() ?: 1

        // ✅ Optional: display version
        versionName = "1.0.${versionCode}"

        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
    }

    signingConfigs {
        maybeCreate("release").apply {
            val storePath = System.getenv("CM_KEYSTORE_PATH")
            val storePass = System.getenv("CM_KEYSTORE_PASSWORD")
            val keyAlias = System.getenv("CM_KEY_ALIAS")
            val keyPass = System.getenv("CM_KEY_PASSWORD")

            // Apply only if all env vars exist (i.e. in Codemagic)
            if (storePath != null && storePass != null && keyAlias != null && keyPass != null) {
                storeFile = file(storePath)
                storePassword = storePass
                this.keyAlias = keyAlias
                keyPassword = keyPass
            }
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}
