<h1 align="center">Pictify 🖼⚡</h1>
<p align="center">Image processing for Flutter with the capabilities of C++</p>

>[!IMPORTANT]
> This plugin is not publicly available (on pub.dev) as the [image package](https://pub.dev/packages/image) covers the same features and more. But you can use it on your own if you wish.

## Getting Started
1. Download this repository and add it to your Flutter project inside the `packages/` folder.
2. Include it in your dependencies inside `pubspec.yaml`:
   ```yaml
   dependencies:
     pictify:
       path: packages/pictify
   ```
3. Run `flutter pub get` to get the related dependencies and you're done!

## Features
✅ Change image brightness  
✅ Turn image to grayscale  
✅ Turn image to negative  
✅ Filter color by RGB channels  
✅ Change image contrast (only available in grasycale by now)  
✅ Apply a threshold to image (converting it to black&white)  
✅ Change each RGB channel intensity independently  

> Don't forget to check out the example app inside `example/main.dart`. 

