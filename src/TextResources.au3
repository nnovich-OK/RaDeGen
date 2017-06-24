#include-once


;TODO should I move all other GUI strings into this file?

Global $RES_version = "v0.1.0.0"
GLobal $RES_url = "http://some.git.repo.com/mine/path"

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
'RaDeGen''s main purpose is to emulate mouse clicks in deck building mode. ' & _
'It adds cards to deck the same way user would do: by clicking some cards on collection view, ' & _
'turning a page when needed and hitting "done" button at the end. ' & _
'To do this, script must know some things like position of controls (cards and buttons) and size of collection. ' & _
'However, there is no easy way to get any data from Hearthstone, so generator fully relies on user''s inputs. '

Global $RES_help_instr1 = _
'INSTRUCTIONS: FIRST RUN' & @CRLF & _
@CRLF & _
'The first run requires much more work, than subsequent one' & @CRLF & @CRLF & _
'1. In Hearthstone open "My Collection"/"New Deck"/Any class/"Custom Deck".' & @CRLF & @CRLF & _
'2. Choose mode (wild/standard) and/or filter cards. All shown cards are the base for random deck.' & @CRLF & @CRLF & _
'3. Count number of 8-card-pages for class cards including the last one (may be not entirely filled). ' & _
'Put number into generator along with number of cards on the last class page.' & @CRLF & @CRLF & _
'4. Repeat for neutral cards. The most tedious part :( Won''t be needed on re-run' & @CRLF & @CRLF & _
'5. Now time to point control coordinates. Hover mouse over top-left card and press ctrl+alt+q' & @CRLF & @CRLF & _
'6. Hover mouse over bot-right card (aka 8th card on page) and press ctrl+alt+w ' & @CRLF & @CRLF & _
'7. Hover mouse over right edge of the collection book, which turns page on click, and press ctrl+alt+e ' & @CRLF & @CRLF & _
'8. Finally, hover mouse over "Done" button and press ctrl+alt+r' & @CRLF & @CRLF & _
'9. Ready to go! Let''s test: open the very first page of displayed cards and hit ctrl+alt+z. '& _
'Generator must create deck of 4 cards: first and last class card, first and last neutral card, then hit "Done"' & @CRLF & @CRLF & _
'10. Everything fine? Clear deck, open the first page of displayed cards and hit ctrl+alt+x. Enjoy!' & _
' If you need to stop generation for some reason, hit ctrl+alt+c'


Global $RES_help_instr2 = _
'INSTRUCTIONS: LATER RUN' & @CRLF & _
@CRLF
;nothing changed - create new empty deck, open first page on collection and hit ctrl+alt+z
;collection changed - hit ctrl+alt+x and check difference
;class changed - presets


Global $RES_license = _
'Copyright (c) 2017 Artem Orlovskii'  & @CRLF & _
@CRLF & _
'Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:' & @CRLF & _
@CRLF & _
'The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.' & @CRLF & _
@CRLF & _
'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.'
