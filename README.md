# Tp3 Audio-foreground-app

Tp3
This is a simple Flutter music app that allows you to play an audio track. It uses the Just Audio package for audio playback and provides a basic user interface with control buttons.

# Flutter Music App

## App Overview
This Flutter music app consists of the following components:

- **Main Page:** The main page displays the album artwork and the currently playing song title. It also provides control buttons to skip previous, pause, play, stop, and repeat.

- **Audio Playback:** The app uses the Just Audio package for audio playback. You can customize the audio source and control the playback using the control buttons on the main page.

- **Foreground Service:** The app uses Flutter Background Service to run audio playback in the background and display a notification when audio is playing in the foreground.

- **Navigation:** There's a navigation button to a "CreateurPage" where you can navigate to a different page.

## Foreground Service
This app utilizes a foreground service to provide a seamless audio playback experience even when the app is in the background. The foreground service ensures that the music continues to play and provides a notification for easy control.

## Credits
This app was created by Hamzaoui Thameur and Omari Hamza. We acknowledge their contributions to the development of this Flutter music app.

## Usage
You can use this app to play audio tracks, control playback, and test background audio playback. Customize the audio source by modifying the `startAudio` function and specifying the desired audio file.

## Screenshot
![App Screenshot](screenshots/screenshot.png)


## Prerequisites

Before you start using this app, make sure you have the following prerequisites installed on your development environment:

- Flutter SDK: Make sure you have Flutter installed. You can follow the installation instructions on the official [Flutter website](https://flutter.dev/docs/get-started/install).

## Getting Started

To get started with this app, follow these steps:

1. Clone this repository to your local machine:

   ```shell
   git clone https://github.com/yourusername/flutter-music-app.git
