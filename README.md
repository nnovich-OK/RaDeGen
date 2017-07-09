# RaDeGen

## Short description
Random deck generator is a tool for Hearthstone video game. Intended to emulate user mouse clicks in deck generation mode in order to build deck out of random garbage.

## Why on earth should anyone need it
Back in good old days, empty deck, automatically filled by Hearthstone, produced 30 pieces of unpredictable garbage to play with. And by unpredictable garbage I mean enormous fun. It used to be simple recipe of great joy: close your eyes, let weird cards form your deck and start incredible friendly challenge featuring angry chicken and magma rager.

However, nothing lasts forever. Blizzard greatly improved card picker and now automatically created decks are pretty much the same solid cards. Searching for the right feature replacement, I surprisingly discovered overcomplicated chain of different plugins. Like "install tracker, exporting collection to one site, then go to another site capable of generating random deck based on the first site API and finally import result into HS via deck tracker" with no way to conceal cards prior to play. Must admit, described solution might be OK from some perspective, but I decided to spend several days on my own minimalistic tool. Intended for personal usage, but shared in hope to be helpful :)

## How does it work
RaDeGen adds cards to deck the same way user would do: by clicking some cards on collection view, turning a page when needed and hitting "done" button at the end. To do this, script must know some things like position of controls (cards and buttons) and size of collection. However, there is no easy way to get any data from Hearthstone, so generator fully relies on user's inputs. Instructions for specifying GUI elements positions and collection size are within the program.

## How do install it?
Copy exe to any folder, where it can create files (like config file), thats it. No installation, integration into the system, registry modification etc. If you're sceptical about random exe from internet, install [AutoIt](https://www.autoitscript.com/site/autoit/), copy source code to some folder and execute directly from  source code by double clicking Radegen.au3.

## Is RaDeGen against Blizzard rules?
Nope:
 - [any app that duplicates what you can do with a pencil and paper already is fine](https://twitter.com/bdbrode/status/511151446038179840) -Ben Brode. Creating random deck is equivalent of throwing paper pieces with card names into a hat and pulling 30 of them out.
 - [It's not against the TOS](https://twitter.com/CM_Zeriyah/status/589171381381672960) -Zeriyah
