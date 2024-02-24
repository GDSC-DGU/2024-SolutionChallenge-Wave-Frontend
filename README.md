
# 2024 Solution Challenge: 🌊Wave
### Wave ThumbNailImage Needed ⭐️


# 🌍 UN SDGs Goals
<img width="220" alt="스크린샷 2024-02-24 오후 10 39 46" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-Wave-Frontend/assets/106448279/62c7d19b-a71f-4ea4-930d-0557d252bad4">

# What is Wave's Solution?
### ***"Wave from us save from war"***
"Wave from us, save from war" is our slogan, under which our app was born with the belief that small ripples can create a massive change.
Our service is dedicated to maintaining and elevating awareness of **ongoing conflicts**, addressing the challenge of **declining public interest as wars continue**.  
By offering an **Interactive War Map** that provides real-time updates and news on conflicts, alongside integrated features for **making donations**, we aim to actively engage the **global community**.  
This approach not only keeps the audience informed about the latest developments in conflict zones but also facilitates **direct support to affected areas**, ensuring that the momentum of global empathy and aid is sustained over time.  


#  ❇️ Architecture
<img width="1004" alt="스크린샷 2024-02-25 오전 12 07 09" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-Wave-Frontend/assets/106448279/9e2f0645-c717-4cb6-bdba-f47ca77b98fe">


# 🛠️Tech Stack🛠️
## Frameworks
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Spring](https://img.shields.io/badge/spring-%236DB33F.svg?style=for-the-badge&logo=spring&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-6DB33F?style=for-the-badge&logo=spring-boot&logoColor=white)
![Flask](https://img.shields.io/badge/flask-%23000.svg?style=for-the-badge&logo=flask&logoColor=white)


## Server
![Google Cloud](https://img.shields.io/badge/Google%20Cloud-4285F4?style=for-the-badge&logo=google-cloud&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white")
![Gunicorn](https://img.shields.io/badge/gunicorn-%298729.svg?style=for-the-badge&logo=gunicorn&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)

## Stack
![JPA](https://img.shields.io/badge/JPA-6DB33F?style=for-the-badge&logo=spring-boot&logoColor=white)
![Spring Security](https://img.shields.io/badge/Spring%20Security-6DB33F?style=for-the-badge&logo=spring-security&logoColor=white)
![JSON Web Tokens](https://img.shields.io/badge/json%20web%20tokens-323330?style=for-the-badge&logo=json-web-tokens&logoColor=pink)
![Hibernate](https://img.shields.io/badge/Hibernate-59666C?style=for-the-badge&logo=hibernate&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![http](https://img.shields.io/badge/http-0.13.6-red?style=for-the-badge)
![uuid](https://img.shields.io/badge/uuid-3.0.7-blue?style=for-the-badge)

# Execution Method
Here's how you can set up a testing environment.
Download the apk file here.
Run the apk file on your phone or the emulator.
To ensure the best experience while testing our app, we recommend testing it in a Pixel 7 Pro API 34 or higher!
### [Wave APK Link](https://apps.apple.com/us/app/인터미션-intermission/id6471970116) ⭐️(최종제출 버전 등록후 수정)


## Flutter Project Build Instructions

#### To run the Flutter project, execute the following commands

```sh
flutter pub get
flutter run

## If you encounter any issues in iOS build, follow these steps to clean your build cache for iOS
cd ios
rm Podfile.lock
rm Podfile
rm -rf Pods
pod cache clean --all
cd ..
flutter clean
flutter pub get
cd ios
pod install
flutter pub get
flutter run

## If you encounter any issues in Android build, follow these steps to clean your build cache for Android 
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter pub get
flutter run

```



# 📸 ScreenShot & Description


# Wave Developers
| NAME                                           | ROLE           | EMAIL                         |
|------------------------------------------------|----------------|-------------------------------|
| [SEUNGJUN KANG](https://github.com/jjuuuunnii) |**Leader**, **Back-End**       | kangseung1110@gmail.com       |
| [DOHYEONG LEE](https://github.com/puretension) | **Front-End**      | gmlcks0513@dgu.ac.kr          |
| [MINSEONG KIM](https://github.com/minseong0324)| **Front-End**      | kwan03240324@gmail.com        |
| [KYOUNGHYUN NAM](https://github.com/Oneourbefore) | **AI** | namkyounghyun1150@gmail.com   |




# 2024-SolutionChallenge-Wave-Frontend
This is 2024 GDSC Solution Challenge Wave Repository.

## 🌊 Wave? 
### ***"Wave from us save from war"***
#### every ripple is a step away from conflict. Let's create waves of change together!

# GitHub Role
This repository follows the following conventions.

## Commit Convention
| Commit Type | Description |
| --- | --- |
| Feat | Add new features |
| Fix | Fix bugs |
| Docs | Modify documentation |
| Style | Code formatting, missing semicolons, no changes to the code itself |
| Refactor | Code refactoring |
| Test | Add test code, refactor test code |
| Chore | Modify package manager, and other miscellaneous changes (e.g., .gitignore) |
| Design | Change user UI design, such as CSS |
| Comment | Add or modify necessary comments |
| Rename | Only changes to file or folder names or locations |
| Remove | Only performing the action of deleting files |
