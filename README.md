# ImageGram

[![Build Status](https://travis-ci.org/alonecuzzo/ImageGram.svg?branch=develop)](https://travis-ci.org/alonecuzzo/ImageGram)

## Use Case Notes
I considered the following use cases:

1. As a user, I would like to see a list of photo thumbnails.
2. As a user, I would like to see a title associated with a photo thumbnail.
3. As a user, I would like to be able to tap a photo thumbnail and see a larger photo.
4. As a user, I would like to tap the larger photo and return to the original list of photo thumbnails.

I considered user stories such as `"As a user, I would like to be notified if there is an error."` as beyond the scope of this assignment.

## Assumptions
* I assumed that the json was to be taken as given.  In a real-world scenario I would've spoken to the API devs and tried to get pagination implemented so that there wouldn't be 5,000 keys pulled in per call.  
* That this should be able to be compilable without using any package managers - that's why all of the frameworks are included.

## Design Choices
* I went with Reactive + MVVM.  The feed's tableView is bound to a backing viewModel, which handles any data transformations that need to occur after the data is fetched from the API and serialized.
* I used the Router pattern and declined to include a Presenter for the `PhotoViewController`.

## Tests
* I used `Quick/Nimble` to test the main viewModel because I enjoy its expressiveness.
* There are [snapshot tests](https://github.com/facebook/ios-snapshot-test-case) for iPhone 7+ only.  I saw generating snapshot tests for every device beyond the scope of this project.

## Extras
* **Travis CI**: The builds can be found [here](https://travis-ci.org/alonecuzzo/ImageGram).
* **Fastlane**: Lane information can be found [here](https://github.com/alonecuzzo/ImageGram/tree/develop/fastlane).
