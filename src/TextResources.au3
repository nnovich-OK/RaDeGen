#include-once


;TODO should I move all other GUI strings into this file?

Global $RES_version = "v0.1.0"
GLobal $RES_url = "https://github.com/nnovich-OK/RandomHsDeckGenerator"

Global $RES_calibration_card0_hotkey_string = "shift+F5"
Global $RES_calibration_card7_hotkey_string = "shift+F6"
Global $RES_calibration_button_nextPage_hotkey_string = "shift+F7"
Global $RES_calibration_button_deckDone_hotkey_string = "shift+F8"

Global $RES_deck_build_test_hotkey_string = "shift+F3"
Global $RES_deck_build_hotkey_string = "shift+F1"
Global $RES_deck_build_cancel_hotkey_string = "shift+F2"


Global $RES_about = _
"Random Deck Generator " & $RES_version & @CRLF & _
@CRLF & _
"Simple tool, which emulates user mouse clicks in order to create random deck in Hearthstone video game." & @CRLF & _
@CRLF & _
"More info, source code and new versions can be found here: " & @CRLF & _
$RES_url & @CRLF & _
@CRLF & _
"Distributed under MIT license, so software provided AS IS " & _
"without warranty of any kind." & @CRLF & _
"Copyright (c) 2017 Artem Orlovskii"


Global $RES_help_intro = _
'INTRO' & @CRLF & _
@CRLF & _
'Back in good old days, empty deck, automatically filled by Hearthstone, produced ' & _
'30 pieces of unpredictable garbage to play with. And by unpredictable garbage I mean enormous fun. ' & _
'It used to be simple recipe of great joy: close your eyes, let weird cards form your deck and ' & _
'start incredible friendly challenge featuring angry chicken and magma rager.' & @CRLF & _
@CRLF & _
'However, nothing lasts forever. Blizzard greatly improved card picker and now automatically ' & _
'created decks are pretty much the same solid cards. Searching for the right feature replacement, I ' & _
'surprisingly discovered overcomplicated chain of different plugins. Like "install tracker, exporting ' & _
'collection to one site, then go to another site capable of generating random deck based on the first site API ' & _
'and finally import result into HS via deck tracker" with no way to conceal cards prior to play. Must admit, ' & _
'described solution might be OK from some perspective, but I decided to spend several days ' & _
'on my own minimalistic tool. Intended for personal usage, but shared in hope to be helpful :)'


Global $RES_help_basics = _
'BASICS' & @CRLF & _
@CRLF & _
'Generator''s main purpose is to emulate mouse clicks in deck building mode. ' & _
'It adds cards to deck the same way user would do: by clicking some cards on collection view, ' & _
'turning a page when needed and hitting "done" button at the end. ' & _
'To do this, script must know some things like position of controls (cards and buttons) and size of collection. ' & _
'However, there is no easy way to get any data from Hearthstone, so generator fully relies on user''s inputs. '


Global $RES_help_instr1 = _
'INSTRUCTIONS: CALIBRATE CONTROLS' & @CRLF & _
@CRLF & _
'Procedure below typically should be done only once. ' & _
'The purpose is to let generator know positions of Hearthstone GUI elements, so generator can click on them: ' & @CRLF & @CRLF & _
'1. In Hearthstone open "My Collection"/"New Deck"/Any class/"Custom Deck".' & @CRLF & @CRLF & _
'2. Hover mouse over top-left card (aka 1st card on page) and press ' & $RES_calibration_card0_hotkey_string & ". " & _
    'You should hear confirmation tone and generator GUI will indicate success in calibration section.' & @CRLF & @CRLF & _
'3. Hover mouse over bot-right card (aka 8th card on page) and press ' & $RES_calibration_card7_hotkey_string & ". " & _
    'Positions of other cards will be calculated automatically.' & @CRLF & @CRLF & _
'4. Hover mouse over right edge of the collection book, which you click to turn page, and press ' & _
    $RES_calibration_button_nextPage_hotkey_string & ". " & @CRLF & @CRLF & _
'5.  Finally, hover mouse over "Done" button and press '  & $RES_calibration_button_deckDone_hotkey_string & ". " & @CRLF & @CRLF & _
'As a result generator can click any card, turn page to the next one and finish deck building. ' & _
'Repeat steps above if controls moved (e.g. changed screen resolution)'


Global $RES_help_instr2 = _
'INSTRUCTIONS: GENERATE DECK' & @CRLF & _
@CRLF & _
'Essencially the process is this: ' & _
'start creating new deck, provide amount of cards you are choosing from to generator ' & _
'and hit hotkey to make everyithing done automatically. Here are details: ' & @CRLF & _
@CRLF & _
'1. In Hearthstone open "My Collection"/"New Deck"/Any class/"Custom Deck".' & @CRLF & @CRLF & _
'2. Choose mode (wild/standard) and/or filter cards. All shown cards are the base for random deck.' & @CRLF & @CRLF & _
'3. Open the last page of class cards. Put its number (shown on page footer) into generator ' & _
    'along with number of cards on this page.' & @CRLF & @CRLF & _
'4. Same for neutral cards: open the last page, put its number and amount of cards on it into generator' & @CRLF & _
@CRLF & _
'You are ready to go! Optionally make a test run to ensure everything operates well: ' & _
'open the first page and hit ' & $RES_deck_build_test_hotkey_string & '.' & _
'Generator will add these cards: ' & @CRLF & _
' - all cards from the first class page to illustrate, that card positions are OK' & @CRLF & _
' - last class card to show, that collection size for class cards is set correctly' & @CRLF & _
' - first and last neutral card from last but one page, so jumping between distant cards works fine' & @CRLF & _
' - last overall card to check, that overall collection size is configured OK' & @CRLF & _
@CRLF & _
'To run generator normally, open the first page of collection and hit ' & $RES_deck_build_hotkey_string &  '.' & _
@CRLF & _
'Any time you want to halt process, press ' & $RES_deck_build_cancel_hotkey_string &  '.' & _
@CRLF


Global $RES_help_limitations = _
'LIMITATIONS' & @CRLF & _
@CRLF & _
'Generator will never click on the same position in collection twice' & @CRLF & _
@CRLF & _
'Reason: no easy way to get card properties. Decision on clicking position twice requires a lot of info: ' & @CRLF & _
' - is card legendary' & @CRLF & _
' - are two card duplicates available' & @CRLF & _
' - was golden card of the same type already added' & @CRLF & _
'This limitation doesn''t impy, that duplicates are eliminated completely. If you have golden and non-golden ' & _
'versions of the same card, resulted deck may include both. As obvious drawback, generator may ' & _
'click on golden and non-golden versions of the same legendary, so resulted deck will miss one card.'


Global $RES_help_troubles = _
'TROUBLESHOOTING' & @CRLF & _
@CRLF & _
'Generated deck misses several cards' & @CRLF & _
' - if you have golden and non-golden version of the same legendary, that may happen. Check limitations.' & @CRLF & _
' - try increasing mouse move time and click delay in settings. Slower PC can''t cope with a lot of clicks' & @CRLF & _
@CRLF & _
'Generation is soooo slow' & @CRLF & _
' - decrease delays in settings, but don''t overdo or PC may miss some clicks as described above'


Global $RES_license = _
'Copyright (c) 2017 Artem Orlovskii'  & @CRLF & _
@CRLF & _
'Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:' & @CRLF & _
@CRLF & _
'The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.' & @CRLF & _
@CRLF & _
'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.'
