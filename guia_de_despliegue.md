# Guía de Despliegue - Bar App (t4_1)

## Despliegue de la Aplicación en Diferentes Plataformas

Esta guía te mostrará cómo preparar y desplegar la aplicación **Bar App T4_1** en las diferentes plataformas soportadas: **Android**, **iOS**, **Web**, **Windows**, **macOS** y **Linux**.

---

## Tabla de Contenidos

1. [Requisitos Previos](#requisitos-previos)
2. [Preparación Inicial](#preparación-inicial)
3. [Despliegue en Android](#despliegue-en-android)
4. [Despliegue en iOS](#despliegue-en-ios)
5. [Despliegue en Web](#despliegue-en-web)
6. [Despliegue en Windows](#despliegue-en-windows)
7. [Despliegue en macOS](#despliegue-en-macos)
8. [Despliegue en Linux](#despliegue-en-linux)

---

## Requisitos Previos

Antes de desplegar la aplicación, asegúrate de tener instalado y configurado lo siguiente:

### Requisitos Generales
- **Flutter**: v3.9.2 o superior ([Descargar](https://flutter.dev/docs/get-started/install))
- **Dart**: v3.9.2 o superior (incluido con Flutter)
- **Git**: Para control de versiones
- Un editor como **VS Code**, **Android Studio** o **Xcode**

### Verificar Instalación
```bash
flutter doctor
```

Este comando verificará que todas las dependencias estén correctamente instaladas.

---

## Preparación Inicial

### 1. Clonar o Descargar el Repositorio

```bash
git clone https://github.com/AngelPG77/t4_1
cd t4_1
```

### 2. Obtener Dependencias

```bash
flutter pub get
```

### 3. Generar Iconos de Lanzamiento

```bash
dart run flutter_launcher_icons
```

Este comando generará los iconos para todas las plataformas usando la imagen en `assets/icons/Icon.png`.

### 4. Verificar que todo está listo

```bash
flutter pub get
flutter doctor -v
```

---

## Despliegue en Android

### Requisitos Específicos para Android
- **Android SDK** 21 o superior (mínimo especificado en pubspec.yaml)
- **Android Studio** o línea de comandos de Android SDK
- Una clave privada de firma (keystore) para producción

### Paso 1: Configurar la Clave de Firma (Producción)

Para crear una clave privada de firma:

```bash
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

Nota: En Windows, usa `%USERPROFILE%\key.jks` en vez de `~/key.jks`

### Paso 2: Configurar la Referencia de la Clave

Edita o crea `android/key.properties`:

```properties
storePassword=<contraseña_del_keystore>
keyPassword=<contraseña_de_la_clave>
keyAlias=key
storeFile=<ruta_del_archivo_key.jks>
```

### Paso 3: Configurar Gradle (android/app/build.gradle.kts)

Asegúrate de que el archivo está configurado correctamente con la clave de firma:

```kotlin
signingConfigs {
    release {
        keyAlias = keyProperties['keyAlias']
        keyPassword = keyProperties['keyPassword']
        storeFile = file(keyProperties['storeFile'])
        storePassword = keyProperties['storePassword']
    }
}

buildTypes {
    release {
        signingConfig = signingConfigs.release
    }
}
```

### Paso 4: Construir el APK de Distribución

Para crear un APK (para desarrollo o pruebas):

```bash
flutter build apk --release
```

El APK estará ubicado en: `build/app/outputs/flutter-apk/app-release.apk`
El APK ya estaría preparado para instalar en un dispositivo móvil.

### Paso 5: Construir el Bundle (Google Play Store)

Para subir a Google Play Store, crea un App Bundle:

```bash
flutter build appbundle --release
```

El bundle estará ubicado en: `build/app/outputs/bundle/release/app-release.aab`

### Paso 6: Subir a Google Play Store

1. Accede a [Google Play Console](https://play.google.com/console)
2. Crea una nueva aplicación
3. Sigue las instrucciones para cargar el `.aab`
4. Completa la información de la aplicación (descripción, capturas, etc.)
5. Envía para revisión

---

## Despliegue en iOS

### Requisitos Específicos para iOS
- **macOS** (no puedes compilar iOS desde Windows/Linux)
- **Xcode** 14.0 o superior
- Una cuenta de desarrollador de Apple
- Un dispositivo iOS o simulador

### Paso 1: Preparar el Proyecto iOS

```bash
flutter clean
flutter pub get
cd ios
pod install --repo-update
cd ..
```

### Paso 2: Configurar Certificados y Perfiles

En macOS, abre Xcode:

```bash
open ios/Runner.xcworkspace
```

En Xcode:
1. Selecciona el proyecto **Runner**
2. Ve a **Signing & Capabilities**
3. Selecciona tu equipo de Apple (Team)
4. Xcode configurará automáticamente los certificados

### Paso 3: Construir para iOS

Para desarrollo:

```bash
flutter build ios
```

Para producción (App Store):

```bash
flutter build ios --release
```

### Paso 4: Crear IPA (para distribuir)

```bash
flutter build ipa --release
```

El IPA estará ubicado en: `build/ios/ipa/`

### Paso 5: Subir a App Store

Opción A: Usando **Xcode Organizer**
1. Abre Xcode: `open ios/Runner.xcworkspace`
2. Ve a **Window > Organizer**
3. Selecciona tu build y haz clic en **Distribute App**
4. Sigue las instrucciones

Opción B: Usando **Transporter**
1. Descarga [Apple Transporter](https://apps.apple.com/app/transporter/id1450874784)
2. Abre el IPA generado
3. Completa la información requerida
4. Envía para revisión

---

## Despliegue en Web

### Requisitos Específicos para Web
- Chrome o navegador moderno para pruebas
- Servidor web o servicio de hosting (Firebase, Netlify, Vercel, etc.)

### Paso 1: Construcción del Proyecto Web

```bash
flutter build web --release
```

Los archivos compilados estarán en: `build/web/`

### Paso 2: Probar Localmente

```bash
cd build/web
python -m http.server 8000
```

Accede a `http://localhost:8000` en tu navegador.

### Paso 3: Desplegar en Vercel

```bash
npm install -g vercel
vercel --prod --public build/web
```

---

## Despliegue en Windows

### Requisitos Específicos para Windows
- **Windows 10** o superior
- **Visual Studio 2022** Community (incluye compilador MSVC)
- **CMake** 3.10 o superior

### Paso 1: Preparar Proyecto Windows

```bash
flutter clean
flutter pub get
```

### Paso 2: Construir para Windows

Para desarrollo:

```bash
flutter run -d windows
```

Para distribución (Release):

```bash
flutter build windows --release
```

Los archivos compilados estarán en: `build/windows/runner/Release/`

### Paso 3: Crear Instalador (MSIX)

El archivo MSIX es el formato moderno de instalación para Windows 10+.

```bash
flutter build windows --release
```

Luego, puedes crear un instalador MSIX usando herramientas como:
- **MSIX Packaging Tool**
- Scripts personalizados de PowerShell

### Paso 4: Distribución

**Opción A: Distribuir archivos ejecutables**
- Comprime la carpeta `build/windows/runner/Release/`
- Comparte el ZIP

**Opción B: Microsoft Store**
1. Prepara un paquete MSIX
2. Registra tu aplicación en [Microsoft Store Partner Center](https://partner.microsoft.com/en-us/dashboard)
3. Sigue las instrucciones para cargar y publicar

---

## Despliegue en macOS

### Requisitos Específicos para macOS
- **macOS 10.13** o superior
- **Xcode 14.0** o superior
- Un Mac con CPU Apple Silicon o Intel

### Paso 1: Preparar Proyecto macOS

```bash
flutter clean
flutter pub get
cd macos
pod install --repo-update
cd ..
```

### Paso 2: Construir para macOS

Para desarrollo:

```bash
flutter run -d macos
```

Para distribución:

```bash
flutter build macos --release
```

Los archivos estarán en: `build/macos/Build/Products/Release/`

### Paso 3: Crear DMG (Disk Image)

```bash
hdiutil create -volname "Bar App" -srcfolder build/macos/Build/Products/Release/ -ov -format UDZO BarApp.dmg
```

### Paso 4: Firmar la Aplicación (Producción)

```bash
codesign --deep --force --verify --verbose --sign "<Identidad de Certificado>" build/macos/Build/Products/Release/t4_1.app
```

### Paso 5: Distribuir

**Opción A: DMG directo**
- Comparte el archivo `.dmg`

**Opción B: Mac App Store**
1. Crea cuenta de desarrollador de Apple
2. Accede a [App Store Connect](https://appstoreconnect.apple.com/)
3. Crea una nueva aplicación
4. Sigue las instrucciones para cargar

---

## Despliegue en Linux

### Requisitos Específicos para Linux
- **Linux** (Ubuntu 20.04 o superior recomendado)
- **CMake 3.10** o superior
- Librerías de desarrollo de GTK 3.0 o superior

### Instalación de Dependencias (Ubuntu/Debian)

```bash
sudo apt-get install -y \
  clang \
  cmake \
  git \
  gtk-3-dev \
  libgtk-3-0 \
  ninja-build \
  pkg-config
```

### Paso 1: Preparar Proyecto Linux

```bash
flutter clean
flutter pub get
```

### Paso 2: Construir para Linux

Para desarrollo:

```bash
flutter run -d linux
```

Para distribución:

```bash
flutter build linux --release
```

Los archivos compilados estarán en: `build/linux/x64/release/bundle/`

---

## Solución de Problemas Comunes

### Flutter doctor reporta errores
```bash
flutter doctor -v
flutter doctor --android-licenses
flutter doctor --ios-licenses
```

### Problemas de compilación de Android
```bash
flutter clean
cd android
./gradlew clean
cd ..
flutter pub get
flutter build apk --release
```

### Problemas de iOS/macOS
```bash
flutter clean
cd ios
rm -rf Pods
rm Podfile.lock
cd ..
flutter pub get
flutter build ios --release
```

### Problemas en Web
Asegúrate de que la carpeta `build/web` no esté en `.gitignore` durante despliegue.

```bash
flutter build web --release --csp
```

### Verificar integridad del proyecto
```bash
flutter analyze
flutter test
```

---

## Contacto y Soporte

Para problemas durante el despliegue:

1. Consulta la [documentación oficial de Flutter](https://flutter.dev/docs)
2. Revisa los logs de compilación completos
3. Ejecuta `flutter doctor -v` para diagnosticar
4. Considera los foros de Flutter en Stack Overflow

---

**Última actualización**: Enero 2026  
**Versión de Flutter soportada**: 3.9.2 o superior  
**Versión de Dart soportada**: 3.9.2 o superior
