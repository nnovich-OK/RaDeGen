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


Func RND_GenerateIds($class_card_chance, $class_cards_amount, $neutral_cards_amount)
    ; Determine number of class and neutral cards in future deck
    $class_card_chance = $class_card_chance/100
    Local $class_cards_in_deck = 0
    Local $neutral_cards_in_deck = 0
    For $i = 1 to 30
        If (Random() < $class_card_chance) Then
            $class_cards_in_deck += 1
        Else
            $neutral_cards_in_deck += 1
        EndIf
    Next
    
    ; if random is going to pick more cards than available, limit it
    If $class_cards_in_deck > $class_cards_amount Then
        $class_cards_in_deck = $class_cards_amount
        $neutral_cards_in_deck = 30 - $class_cards_in_deck
    ElseIf $neutral_cards_in_deck > $neutral_cards_amount Then
        $neutral_cards_in_deck = $neutral_cards_amount
        $class_cards_in_deck = 30 - $neutral_cards_in_deck
    EndIf
   
    Local $class_deck[$class_cards_amount]
    For $i = 0 To $class_cards_amount-1
        $class_deck[$i] = $i
    Next
    RND_RandomSelection($class_deck, $class_cards_in_deck)
    
    Local $neutral_deck[$neutral_cards_amount]
    For $i = 0 To $neutral_cards_amount-1
        $neutral_deck[$i] = $i + $class_cards_amount
    Next
    RND_RandomSelection($neutral_deck, $neutral_cards_in_deck)
    
    
    Local $deck = $class_deck
    _ArrayConcatenate ($deck, $neutral_deck)
    _ArrayDisplay($deck)
    
    Return $deck
EndFunc


; Randomly selects specified number of elements from array by doing this:
;  - shuffles first N positions of array using Fisher–Yates alogrithm
;  - drops rest of array
;  - sorts the result
Func RND_RandomSelection(ByRef $array, $selection_size)
    If Not IsArray($array) Then Return SetError(1, 0, -1)
    Local $array_size = UBound($array)
    If $array_size<$selection_size Then Return SetError(1, 0, -1)
    
    For $i = 0 to $selection_size-1 
        Local $pos = Random($i, $array_size-1, 1)
        $tmp = $array[$pos]
        $array[$pos] = $array[$i]
        $array[$i] = $tmp
    Next
    
    Redim $array[$selection_size]
    _ArraySort($array)
EndFunc