# ImageGram

[![Build Status](https://travis-ci.org/alonecuzzo/ImageGram.svg?branch=develop)](https://travis-ci.org/alonecuzzo/ImageGram)

## Use Case Notes
* There is a main feed that contains a tableView that is populated by the json endpoint that was supplied in the assignment.
* When a cell is tapped a child viewController is presented and it shows the other second image provided by the json.

## Assumptions
* I assumed the happy path for this assignment, so I did not handle error states, and I did not design error handling screens.  The code at this point represents how I would produce a "happy path" iteration on the functionality.  I felt that designing for those use cases was beyond the scope of this assignment.
* I assumed that the json was to be taken as given.  In a real-world scenario I would've spoken to the API devs and tried to get pagination implemented so that there wouldn't be 5,000 keys pulled in per call.  

## Design Choices
* I went with Reactive + MVVM.  The feed's tableView is bound to a backing viewModel, which handles any data transformations that need to occur after the data is fetched from the API and serialized.

## Tests
* I used `Quick/Nimble` to test the main viewModel because I enjoy its expressiveness.
* There are snapshot tests for iPhone 7+ only.  I saw generating snapshot tests for every device beyond the scope of this project.

## Extras
* **Travis CI**: The builds can be found [here](https://travis-ci.org/alonecuzzo/ImageGram).
* **Fastlane**: lane information can be found [here](https://github.com/alonecuzzo/ImageGram/tree/develop/fastlane).
