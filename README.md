# PicViewer
_
    <img src="https://user-images.githubusercontent.com/105886145/171062197-9a4f621d-617f-42b2-95be-66e92f0b36be.gif" width="400"> 
    
### About ###
Swift/UIKit app for viewing random images via Unsplash API

#### Features: ####
   - Getting random image with description or maunally with button
   - Displayed image could be liked
   - All liked images store in Favorites gallery
   - Favorite images could be removed
   - Popup alerts when Internet is down or on incorrect data from server
   - On start without Internet opens last dusplayed image with description

#### Technology stack: ####
  - Swift/UIKit
  - Architecture MVC
  - Dependencies with CocoaPods
  - Networking with URLSession, JSONDecoder
  - Data storing with Realm
  - Caching images with SDWebImage


### Installation ###
```sh
   cd .../PicViewer
   pod install 
```
