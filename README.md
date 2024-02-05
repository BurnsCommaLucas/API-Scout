# API-Scout

A small scale API testing tool built explicitly for the Mac. 

Currently handles a very minimal set of functionality and is not a well-behaved app by a long shot.

This is both the first Mac App and the first Swift I have written. If you have interest in this product, please bear with me as I learn.

As much of the UI as possible is written with SwiftUI just because that's proven to be the simplest for 90% of what I want this app to do. Turns out [ATP](https://atp.fm) was right, SwiftUI is really great until you find something it can't do, and then it's back down to AppKit.[^1]

## Planned Additions & Improvements
This isn't an exhaustive list – though it is an exhausting list to write (ba dum tiss) – it's just the things I can think of off the top of my head that probably belong in either of A) a well behaved Mac App, or B) An API testing App.

- [ ] State management
  - [ ] Creating/destroying requests
  - [ ] Saving requests between restarts (🤦)
  - [ ] Request folders
  - [ ] Request import/export (probably just to json but maybe cURL too)
  - [ ] User Preferences
    - [ ] Editor themes
    - [ ] Editor bracket/quote auto-close
    - [ ] Light/dark themes[^2]
- [ ] Requests
  - [ ] Custom headers
  - [ ] Query param editor
  - [ ] Editor highlighting based on selected body type
  - [ ] Encoding based on `Content-Type` header
  - [ ] `User-Agent` header
- [ ] Responses
  - [ ] Auto formatting
  - [ ] Decoding based on `Content-Type` header
- [ ] Environment
  - [ ] Variables
  - [ ] Variable groups
- [ ] Auth
  - [ ] Bearer
  - [ ] Basic
  - [ ] Custom key
  - [ ] Digest
  - [ ] OAuth 1.0
  - [ ] OAuth 2.0 (probably)
- [ ] More request body types
  - [ ] XML
  - [ ] YAML
  - [ ] Forms
  - [ ] Custom
  - [ ] GraphQL (maybe)
- [ ] Cookies (maybe??)
- [ ] Better UI 😰


[^1]: Anyone know a good resource for learning AppKit and how the hell custom `NSViewRepresentable`s work?

[^2]: Honestly not sure if this is something I'll need to handle specifically or if that's a system thing I can just latch on to