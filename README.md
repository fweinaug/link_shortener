![Firebase Hosting](https://github.com/fweinaug/link_shortener/workflows/Firebase%20Hosting/badge.svg)

# link_shortener

A simple Flutter application which is able to **transform a given https link into a minimized and trackable link**.
The app **tracks a click** on such a generated link and also **redirects the user to the initial URL**.
The app provides a **simple, reactive, report view** where the user can see the number of clicks tracked per link.

## Stack

The app was built with [Flutter Web](https://flutter.dev/) (beta), and [Google Firebase](https://firebase.google.com/) 
for data storage and hosting.

### Firebase

Links and clicks are stored in Firebase's Firestore database.

The app is hosted on Firebase Hosting. A GitHub action automatically builds and deploys the app on every push and 
PR on the master branch. [Link](https://shortie-33b73.web.app/)
