# zena
[![built with flutter](https://img.shields.io/badge/built%20with-flutter-blue.svg?style=flat-square)](https://www.flutter.io)

More info [here](http://www.tarunkurella.tk/zena/).

![](https://i.imgur.com/lXe4TLZ.gif)

#### 1. [Setup Flutter](https://flutter.io/setup/)

#### 2. Clone the repo

```sh
$ git clone https://github.com/TarunKurella/zena.git
$ cd zena/
```

#### 3. Seting up your DialogFlow Agent

1. First of all, we need to create a Google Cloud Platform Project using https://console.cloud.google.com/
* Create or select an existing GCP project.
* Enable the Dialogflow V2 API for that project.
* Click on ENABLE APIS AND SERVICES and search for Dailog flow api. Then enable it.
* From the Google Cloud service accounts page, select your project.
* Download a private key as JSON.
* From the GCP console, go to APIs and Services and click on credentials.
* Click on Create credentials and choose Service account key.
* Select your service account from the dropdown, choose JSON and click Create. This will download the JSON key to your computer. Save it securely.
* Copy its contents to config/dialogflow.json

# What's Next?
 - [x] Implementing Chatbot 
 - [x] Connecting API's
 - [x] Improving UI and animations
 - [x] Training Dialogflow Agent
 - [ ] Using Webhooks to Exract usefull information from chat
 - [ ] Designing engaging conversations
 - [ ] predifining personality traits for roles , against which candidates profile shall be compared
 - [ ] Clean up code

