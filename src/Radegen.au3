#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>
#include "ScriptLauncher.au3"
#include "SoundManager.au3"
#include "Randomizer.au3"
#include "GuiManager.au3"
#include "FileManager.au3"
#include <Math.au3>

;--------------------------------------------------------
; declaration of all global variables with default values
;--------------------------------------------------------

;calibration variables
Global $calibration_card0_pos[2] = [0, 0]
Global $calibration_card7_pos[2] = [0, 0]
Global $calibration_card_all_pos[8][2]

Global $calibration_button_nextPage_pos[2] = [0, 0]
Global $calibration_button_deckDone_pos[2] = [0, 0]


Global Const $calibration_card0_hotkey = "+{F5}" ; shift+F5
Global Const $calibration_card7_hotkey = "+{F6}" ; shift+F6
Global Const $calibration_button_nextPage_hotkey = "+{F7}" ; shift+F7
Global Const $calibration_button_deckDone_hotkey = "+{F8}" ; shift+F8

Global Const $deck_build_test_hotkey = "+{F3}" ; shift+F3
Global Const $deck_build_hotkey = "+{F1}" ; shift+F1
Global Const $deck_build_cancel_hotkey = "+{F2}" ; shift+F2

;deck size variables
Global $card_class_page_count = 0
Global $card_class_tail_count = 0
Global $card_neutral_page_count = 0
Global $card_neutral_tail_count = 0

;generation config
Global $generator_seed = 0    ; 0 means "use time for seed"

Global $settings_class_card_chance = 0
Global $settings_mouse_move_slowness = 0
Global $settings_mouse_click_delay = 0


;----------------------------------------------------------------------
; parsing config if exist, updating variables. Create config otherwise.
;----------------------------------------------------------------------
FM_CalibrationStateLoad($calibration_card0_pos, _
        $calibration_card7_pos, _
        $calibration_button_nextPage_pos, _
        $calibration_button_deckDone_pos)
        
FM_CollectionStateLoad($card_class_page_count, _
        $card_class_tail_count, _
        $card_neutral_page_count, _
        $card_neutral_tail_count)

SettingsApply()

;----------------------------------------------------------------------
; auxiliary modules init
;----------------------------------------------------------------------
SL_Init()                     ;hotkey scripts launcher
RND_SeedInit($generator_seed) ;randomizer


;--------------------------------------------------------
; init GUI based on known config
;--------------------------------------------------------
GUI_Init()
CollectionDisplayRefresh()
CalibrationDisplayRefresh()

GUI_SettingsCbRegister("SettingsApply")
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
        MsgBox($MB_TASKMODAL, "Error", "Calibration isn't finished")
        Return false
    EndIf
    
    If $card_neutral_page_count < 0 Then
        MsgBox($MB_TASKMODAL, "Error", "Class pages can't be more than overall pages")
        Return false
    EndIf
    
    ;tails must be 1 to 8
    ;pages must be >= 0
    If $card_class_tail_count < 1 OR $card_class_tail_count > 8 _
      OR $card_neutral_tail_count < 1 OR $card_neutral_tail_count > 8 _
      OR $card_class_page_count <0 OR $card_neutral_page_count < 0 _
    Then
        ;Should never get here, so 
        MsgBox($MB_TASKMODAL, "Error", "Parameters are weird. Try closing app, removing config file and launching app again")
        Return false
    EndIf
    
    ;Overall number of cards must be >= 30
    If (CardClassCount() + CardNeutralCount()) < 30 Then
        MsgBox($MB_TASKMODAL, "Error", "There is less than 30 unique cards, so can't build the deck")
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
    Local $deck[1] = [-1]
    
    If $is_test_mode Then
        ;all cards from first page
        Local $first_page_size = _Min(8, $card_class_count)
        Local $test_deck_size = $first_page_size
        Redim $deck[$test_deck_size]
        For $i = 0 to $first_page_size-1
            $deck[$i] = $i
        Next
        
        ;last class card if not there already
        If $card_class_count > 8 Then
            $test_deck_size += 1;
            Redim $deck[$test_deck_size]
            $deck[$test_deck_size-1] = $card_class_count-1
        EndIf
        
        ;first and last card from last but one neutral page
        If $card_neutral_count > 8 Then
            $test_deck_size += 2;
            Redim $deck[$test_deck_size]
            $deck[$test_deck_size-2] = $card_class_count + $card_neutral_count - $card_neutral_tail_count - 8
            $deck[$test_deck_size-1] = $card_class_count + $card_neutral_count - $card_neutral_tail_count - 1
        EndIf
        
        ;last neutral card
        If $card_neutral_count > 0 Then
            $test_deck_size += 1;
            Redim $deck[$test_deck_size]
            $deck[$test_deck_size-1] = $card_class_count + $card_neutral_count-1
        EndIf
    Else
        $deck = RND_GenerateIds($settings_class_card_chance, $card_class_count, $card_neutral_count)
    EndIf
    
    If @error <> 0 OR Not IsArray($deck) Then
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
                    $settings_mouse_move_slowness)
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
            $settings_mouse_move_slowness)
    Next
    
    If SL_QueryStopFlag() Then
        Return
    EndIf
    MouseClick($MOUSE_CLICK_MAIN, _
        $calibration_button_deckDone_pos[0], _
        $calibration_button_deckDone_pos[1], _
        1, _
        $settings_mouse_move_slowness)
EndFunc

Func CollectionStateUpdate()
    $card_class_page_count = GUI_ClassPageCountGet()
    $card_class_tail_count = GUI_ClassTailCountGet()
    $card_neutral_page_count = GUI_OverallPageCountGet() - GUI_ClassPageCountGet()
    $card_neutral_tail_count = GUI_OverallTailCountGet()
EndFunc

Func CollectionStateSave()
    FM_CollectionStateSave($card_class_page_count, _
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

Func SettingsApply()
    FM_SettingsLoad($settings_class_card_chance, _
            $settings_mouse_move_slowness, _
            $settings_mouse_click_delay)

    AutoItSetOption("MouseClickDelay", $settings_mouse_click_delay)
EndFunc