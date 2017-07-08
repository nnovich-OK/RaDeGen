#include-once
#include <AutoItConstants.au3>
#include <Array.au3>

Func RND_SeedInit($seed)
    If $seed = 0 Then
        SRandom(Number(@SEC & @MSEC))
    Else
        SRandom($seed)
    EndIf
EndFunc

; Param - collection representation, which is array with size equal
;   to number of unique cards in collection. Each array item represents
;   quantity of avaialbe cards with ID equal to item index (quantity can be 1 or 2 only)
;   Intentionally passed by copy, modification is required
; Return - array of 30 ascending integers with included card IDs
Func RND_GenerateIds($collection)
    If Not IsArray($collection) Then Return SetError(1, 0, -1)

    Local $collectin_size = UBound($collection)
    Local $deck[30]
    Local $deck_index = 0
    
    While $deck_index < 30
        Local $rnd = Random(0, $collectin_size-1, 1)
        If $collection[$rnd] > 0 Then
            $collection[$rnd] -= 1
            $deck[$deck_index] = $rnd
            $deck_index += 1
        EndIf
    WEnd
    
    _ArraySort($deck)
    
    Return $deck
EndFunc