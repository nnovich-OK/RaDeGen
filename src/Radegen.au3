#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>
#include "ScriptLauncher.au3"
#include "SoundManager.au3"
#include "Randomizer.au3"
#include "GuiManager.au3"
#include "FileManager.au3"

;--------------------------------------------------------
; declaration of all global variables with default values
;--------------------------------------------------------

;calibration variables
Global $calibration_card0_pos[2] = [0, 0]
Global $calibration_card7_pos[2] = [0, 0]
Global $calibration_card_all_pos[8][2]

Global $calibration_button_nextPage_pos[2] = [0, 0]
Global $calibration_button_deckDone_pos[2] = [0, 0]


Global Const $calibration_card0_hotkey = "^!q" ; ctrl-alt-q
Global Const $calibration_card7_hotkey = "^!w" ; ctrl-alt-w
Global Const $calibration_button_nextPage_hotkey = "^!e" ; ctrl-alt-e
Global Const $calibration_button_deckDone_hotkey = "^!r" ; ctrl-alt-r
#cs
Global Const $deck_build_test_hotkey = "^!z" ; ctrl-alt-z
Global Const $deck_build_hotkey = "^!x" ; ctrl-alt-x
Global Const $deck_build_cancel_hotkey = "^!c" ; ctrl-alt-c
#ce

Global Const $deck_build_test_hotkey = "^z" ; ctrl-z
Global Const $deck_build_hotkey = "^x" ; ctrl-x
Global Const $deck_build_cancel_hotkey = "^c" ; ctrl-c

;deck size variables
Global $card_preset = ""
Global $card_class_page_count = 0
Global $card_class_tail_count = 0
Global $card_neutral_page_count = 0
Global $card_neutral_tail_count = 0

;generation config
Global $generator_seed = 0    ; 0 means "use time for seed"

;For me: 500 works fine, 400 fine, 300 bad, 350 rarely bad
;For Anton: 700 works fine, 500 rarely bad
Global $mouse_click_delay = 500	

;For me: 1 works fine
;For Anton: 4 works fine, 1 is bad (missing ~4 cards)
Global $mouse_move_speed = 1


;----------------------------------------------------------------------
; auxiliary modules init
;----------------------------------------------------------------------
AutoItSetOption("MouseClickDelay", $mouse_click_delay)
SL_Init()                     ;hotkey scripts launcher
RND_SeedInit($generator_seed) ;randomizer


;----------------------------------------------------------------------
; parsing config if exist, updating variables. Create config otherwise.
;----------------------------------------------------------------------
FM_Init()

FM_CalibrationStateLoad($calibration_card0_pos, _
		$calibration_card7_pos, _
		$calibration_button_nextPage_pos, _
		$calibration_button_deckDone_pos)
		
$card_preset = FM_PresetDefaultGet()
FM_CollectionStateLoad($card_preset, _
		$card_class_page_count, _
		$card_class_tail_count, _
		$card_neutral_page_count, _
		$card_neutral_tail_count)

;--------------------------------------------------------
; init GUI based on known config
;--------------------------------------------------------
GUI_Init(FM_PresetNamesGet(), FM_PresetDefaultGet())
CollectionDisplayRefresh()
CalibrationDisplayRefresh()

GUI_PresetCbRegister("OnPresetModified")
GUI_ClassPageCountCbRegister("OnClassPageCountModified")
GUI_ExitCbRegister("OnExit")
GUI_Show()


;--------------------------------------------------------
; set hotkeys
;--------------------------------------------------------
HotKeySet($calibration_card0_hotkey, "CalibrateHsControl")
HotKeySet($calibration_card7_hotkey, "CalibrateHsControl")
HotKeySet($calibration_button_nextPage_hotkey, "CalibrateHsControl")
HotKeySet($calibration_button_deckDone_hotkey, "CalibrateHsControl")

HotKeySet($deck_build_test_hotkey, "DeckBuildCaller")
HotKeySet($deck_build_hotkey, "DeckBuildCaller")
HotKeySet($deck_build_cancel_hotkey, "SL_ScriptHalt")

;--------------------------------------------------------
; main loop, never exits unless GUI is closed
;--------------------------------------------------------
While true
	SL_ScriptLaunch()
WEnd



Func CalibrationCardsAllPosUpdate()
	Local $row_top_y = $calibration_card0_pos[1]
	Local $row_bot_y = $calibration_card7_pos[1]
	
	Local $col0_x = $calibration_card0_pos[0]
	Local $col3_x = $calibration_card7_pos[0]
	Local $col_delta = Int( ($col3_x - $col0_x) /3 )
	Local $col1_x = $col0_x + $col_delta
	Local $col2_x = $col3_x - $col_delta

	$calibration_card_all_pos[0][0] = $calibration_card0_pos[0]
	$calibration_card_all_pos[0][1] = $calibration_card0_pos[1]
	
	$calibration_card_all_pos[1][0] = $col1_x
	$calibration_card_all_pos[1][1] = $row_top_y
	
	$calibration_card_all_pos[2][0] = $col2_x
	$calibration_card_all_pos[2][1] = $row_top_y
	
	$calibration_card_all_pos[3][0] = $col3_x
	$calibration_card_all_pos[3][1] = $row_top_y
	
	$calibration_card_all_pos[4][0] = $col0_x
	$calibration_card_all_pos[4][1] = $row_bot_y
	
	$calibration_card_all_pos[5][0] = $col1_x
	$calibration_card_all_pos[5][1] = $row_bot_y
	
	$calibration_card_all_pos[6][0] = $col2_x
	$calibration_card_all_pos[6][1] = $row_bot_y
	
	$calibration_card_all_pos[7][0] = $calibration_card7_pos[0]	
	$calibration_card_all_pos[7][1] = $calibration_card7_pos[1]
EndFunc

Func CalibrateHsControl()
	Local $gui_ctrl_id = $gui_ctrl_card0

	Switch @HotKeyPressed 
		case $calibration_card0_hotkey
			$calibration_card0_pos = MouseGetPos()
			$gui_ctrl_id = $gui_ctrl_card0
			
		case $calibration_card7_hotkey
			$calibration_card7_pos = MouseGetPos()
			$gui_ctrl_id = $gui_ctrl_card7
			
		case $calibration_button_nextPage_hotkey
			$calibration_button_nextPage_pos = MouseGetPos()
			$gui_ctrl_id = $gui_ctrl_nextPage
			
		case $calibration_button_deckDone_hotkey
			$calibration_button_deckDone_pos = MouseGetPos()
			$gui_ctrl_id = $gui_ctrl_deckDone

	EndSwitch
	
	GUI_CalibrationStateChange($gui_ctrl_id, true)
	CalibrationStateSave()
	SM_NotifySuccess()
EndFunc


Func SanityCheck()
	;Calibration must be finished
	If   $calibration_card0_pos[0] <= 0 OR $calibration_card0_pos[1] <= 0 _
	  OR $calibration_card7_pos[0] <= 0 OR $calibration_card7_pos[1] <= 0 _
	  OR $calibration_button_nextPage_pos[0] <= 0 OR $calibration_button_nextPage_pos[1] <= 0 _
	  OR $calibration_button_deckDone_pos[0] <= 0 OR $calibration_button_deckDone_pos[1] <= 0 _
	Then
		Return false
	EndIf
	
	;tails must be 1 to 8
	;pages must be >= 0
	If $card_class_tail_count < 1 OR $card_class_tail_count > 8 _
	  OR $card_neutral_tail_count < 1 OR $card_neutral_tail_count > 8 _
	  OR $card_class_page_count <0 OR $card_neutral_page_count < 0 _
 	Then
		Return false
	EndIf
	
	;Overall number of cards must be >= 30
	If (CardClassCount() + CardNeutralCount()) < 30 Then
		Return false
	Endif
	
	Return true
	
EndFunc

Func DeckBuildCaller()
	SL_ScriptAssign(DeckBuild)
EndFunc

Func DeckBuild()
	CollectionStateUpdate()
	
	If NOT SanityCheck() Then
		SM_NotifyFailure()
		Return SetError(1, 0, -1)
	EndIf
	
	CollectionStateSave()
	CalibrationCardsAllPosUpdate()
	
	Local $is_test_mode = (@HotKeyPressed == $deck_build_test_hotkey)
	Local $card_class_count = CardClassCount()
	Local $card_neutral_count = CardNeutralCount()
	Local $deck = Null
	
	If $is_test_mode Then
		;TODO not first neutral, but first on page prior to last
		If $card_class_count > 0 AND $card_neutral_count > 0 Then
			Local $deck[4] = [0, $card_class_count-1, $card_class_count, $card_class_count + $card_neutral_count-1]
		Else
			Local $deck[2] = [0, $card_class_count + $card_neutral_count-1]
		EndIf
	Else
		Local $collection = CollectionGet()
		$deck = RND_GenerateIds($collection)
	EndIf
	
	If Not IsArray($deck) Then
		SM_NotifyFailure()
		Return SetError(1, 0, -1)
	EndIf
	
	DeckPick($deck)
	
	SM_NotifyLongTaskFinished()
EndFunc

Func CardClassCount()
	if $card_class_page_count > 0 Then
		Return ($card_class_page_count - 1) * 8 + $card_class_tail_count
	EndIf
	
	Return 0
EndFunc

Func CardNeutralCount()
	if $card_neutral_page_count > 0 Then
		Return ($card_neutral_page_count - 1) * 8 + $card_neutral_tail_count
	EndIf
	
	Return 0
EndFunc

; Return array with length equal to total card count, filled with 1.
; Represents possibility to include multiple cards of the same type.
; E.g. $collection[3] = 2 means collection has two cards with ID=3
; and they both are allowed to be included (non-legendary)
; However, currently no support for duplicates :( 
Func CollectionGet()
	Local $card_total_count = CardClassCount() + CardNeutralCount()
	Local $collection[$card_total_count]
	For $i = 0 To $card_total_count-1
		$collection[$i] = 1
	Next
	Return $collection
EndFunc

Func DeckPick($deck)
	If Not IsArray($deck) Then Return SetError(1, 0, -1)
	
	Local $cur_page = -1
	Local $min_card_id = -1
	Local $max_card_id = -1
	
	For $i = 0 to UBound($deck)-1
		Local $cur_card_id = $deck[$i]
		While $cur_card_id >$max_card_id
			If $cur_page <> -1 Then
				If SL_QueryStopFlag() Then
					Return
				EndIf
				MouseClick($MOUSE_CLICK_MAIN, _
					$calibration_button_nextPage_pos[0], _
					$calibration_button_nextPage_pos[1], _
					1, _
					$mouse_move_speed)
			EndIf
			$cur_page += 1
			$min_card_id = $max_card_id + 1
			If $cur_page = $card_class_page_count - 1 Then
				$max_card_id = $min_card_id + $card_class_tail_count - 1
			ElseIf $cur_page = $card_class_page_count + $card_neutral_page_count - 1 Then
				$max_card_id = $min_card_id + $card_neutral_tail_count - 1
			Else
				$max_card_id = $min_card_id + 7
			EndIf
			
		WEnd
		
		Local $pos_index = $cur_card_id - $min_card_id
		If SL_QueryStopFlag() Then
			Return
		EndIf
		MouseClick($MOUSE_CLICK_MAIN, _
			$calibration_card_all_pos[$pos_index][0], _
			$calibration_card_all_pos[$pos_index][1], _
			1, _
			$mouse_move_speed)
	Next
	
	If SL_QueryStopFlag() Then
		Return
	EndIf
	MouseClick($MOUSE_CLICK_MAIN, _
		$calibration_button_deckDone_pos[0], _
		$calibration_button_deckDone_pos[1], _
		1, _
		$mouse_move_speed)
EndFunc

Func CollectionStateUpdate()
	$card_preset = GUI_PresetGet()
	$card_class_page_count = GUI_ClassPageCountGet()
	$card_class_tail_count = GUI_ClassTailCountGet()
	$card_neutral_page_count = GUI_OverallPageCountGet() - GUI_ClassPageCountGet()
	$card_neutral_tail_count = GUI_OverallTailCountGet()
EndFunc

Func CollectionStateSave()
	FM_CollectionStateSave($card_preset, _
		$card_class_page_count, _
		$card_class_tail_count, _
		$card_neutral_page_count, _
		$card_neutral_tail_count)
EndFunc

Func CalibrationStateSave()
	FM_CalibrationStateSave($calibration_card0_pos, _
		$calibration_card7_pos, _
		$calibration_button_nextPage_pos, _
		$calibration_button_deckDone_pos)
EndFunc

Func OnPresetModified()
	Local $new_preset = GUI_PresetGet()
	If $new_preset = $card_preset Then Return
	
	;save data for old preset before switching
	Local $old_preset = $card_preset
	CollectionStateUpdate()		;at this point $card_preset represents new one, other data represents old
	FM_CollectionStateSave($old_preset, _
		$card_class_page_count, _
		$card_class_tail_count, _
		$card_neutral_page_count, _
		$card_neutral_tail_count)
		
	;load data for new preset
	FM_CollectionStateLoad($card_preset, _
		$card_class_page_count, _
		$card_class_tail_count, _
		$card_neutral_page_count, _
		$card_neutral_tail_count)

	CollectionDisplayRefresh()
EndFunc

; This approach is arguable, but I consider it to be more handy than ambigous
;
; On update for class page count, check if user modified overall page count.
; If not, then automatically update it along with class page count, otherwise leave unaffected
;
; It makes switching between presets of the same mode much easier with no need to adjust overall page counter
; Example: user played with wild pal, then switched to wild priest. Priest has two less class pages than pal,
; while neutral cards are obviously the same. All user need to do is decrease priest page count.
; However, if user already adjusted overall page count, it probably represents final value, so don't touch it.
Func OnClassPageCountModified()
	If $card_class_page_count + $card_neutral_page_count <> GUI_OverallPageCountGet() Then Return
	
	$card_class_page_count = GUI_ClassPageCountGet()	
	GUI_OverallPageCountSet($card_class_page_count + $card_neutral_page_count)
EndFunc

Func OnExit()
	CollectionStateUpdate()
	CollectionStateSave()
	Exit
EndFunc

Func CollectionDisplayRefresh()
	GUI_ClassPageCountSet($card_class_page_count)
	GUI_ClassTailCountSet($card_class_tail_count)
	GUI_OverallPageCountSet($card_neutral_page_count + $card_class_page_count)
	GUI_OverallTailCountSet($card_neutral_tail_count)
EndFunc

Func CalibrationDisplayRefresh()
	If   $calibration_card0_pos[0] > 0 AND $calibration_card0_pos[1] > 0 Then
		GUI_CalibrationStateChange($gui_ctrl_card0, true)
	EndIf

	If $calibration_card7_pos[0] > 0 AND $calibration_card7_pos[1] > 0 Then
		GUI_CalibrationStateChange($gui_ctrl_card7, true)
	EndIf

	If $calibration_button_nextPage_pos[0] > 0 AND $calibration_button_nextPage_pos[1] > 0 Then
		GUI_CalibrationStateChange($gui_ctrl_nextPage, true)
	EndIf

	If $calibration_button_deckDone_pos[0] > 0 AND $calibration_button_deckDone_pos[1] > 0 Then
		GUI_CalibrationStateChange($gui_ctrl_deckDone, true)
	EndIf
EndFunc