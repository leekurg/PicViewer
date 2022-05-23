# PicViewer
Swift/UIKit app for viewing random images via Unsplash API

### Installation ####
```sh
   cd .../PicViewer
   pod install 
```

#### Features: ####
   - Getting random image with description on timeout or maunally with button
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
