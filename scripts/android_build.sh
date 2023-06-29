if [ $3 == "bundle" ]
then
flutter build appbundle --build-name=$1 --build-number=$2
open build/app/outputs/bundle/release
else
flutter build apk --build-name=$1 --build-number=$2
open build/app/outputs/flutter-apk
fi



# example: sh scripts/android_build.sh 0.0.1 1 bundle
# example: sh scripts/android_build.sh 0.3.4 15 apk