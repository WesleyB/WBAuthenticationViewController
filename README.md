# WBAuthenticationViewController
A UIViewController subclass for authenticating users

## Demo

<img alt="Standard Unlock Keypad" src="https://github.com/WesleyB/WBAuthenticationViewController/blob/master/screenshots/sc_normal.png" height="400"> <img alt="Scrambled Unlock Keypad" src="https://github.com/WesleyB/WBAuthenticationViewController/blob/master/screenshots/sc_scramble.png" height="400"> <img alt="Emoji Unlock Keypad" src="https://github.com/WesleyB/WBAuthenticationViewController/blob/master/screenshots/sc_emoji.png" height="400">

The demo is a basic example where the initial vc presents the authentication vc. A better context for presentation in a larger application would invovle creating a new UIWindow with WBAVC as the rootViewController.

## Features

- Initialize a key with an Int identifier or a String
- Integration with the Keychain to store passcode
- Option to scramble keys to add a layer of abstraction between the keypad and prying eyes. No more memorizing people's passcodes by watching finger movement.
- Option to authenticate with Touch ID
- When supplied an Int as an identifier, keypad buttons can generate their subtext

## TODO:

- Add a time based lockout when there have been too many failed attempts
- Localize Strings
- Turn into a Pod

## License

WBAuthenticationViewController is released under the MIT License. See the LICENSE file for more info.

## Contact

Feel free to reach out on Twitter at [@WesleyBevins](https://twitter.com/WesleyBevins)

