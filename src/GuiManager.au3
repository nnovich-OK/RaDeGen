#include-once
#include <EditConstants.au3>
#include <ComboConstants.au3>
#include "TextResources.au3"

;----------------------------------------------------------------------
; handlers
;----------------------------------------------------------------------
Global Enum $gui_ctrl_card0, $gui_ctrl_card7, $gui_ctrl_nextPage, $gui_ctrl_deckDone, $gui_ctrl_last
Global $gui_ctrlId_calibration[$gui_ctrl_last]

Global $gui_ctrlId_class_page_count
Global $gui_ctrlId_class_tail_count[8]
Global $gui_ctrlId_overall_page_count
Global $gui_ctrlId_overalll_tail_count[8]

Global $gui_ctrlId_menu_info

Global $gui_ctrlId_menu_help
Global $gui_ctrlId_menuItem_about
Global $gui_ctrlId_menuItem_lic

Global $gui_ctrlId_menu_help_intro
Global $gui_ctrlId_menu_help_basics
Global $gui_ctrlId_menu_help_instr1
Global $gui_ctrlId_menu_help_instr2

;----------------------------------------------------------------------
; general settings
;----------------------------------------------------------------------
Global Const $gui_group_margin_outer_side = 15
Global Const $gui_group_margin_outer_top = 15
Global Const $gui_group_margin_outer_bot = 15    ;probably, need to remove

Global Const $gui_group_margin_inner_side = 25
Global Const $gui_group_margin_inner_top = 40

Global Const $gui_group_gap_inner = 60
Global Const $gui_group_tab_inner = 25

Global Const $gui_inputXXX_width = 75
Global Const $gui_inputXXX_height = 25
Global Const $gui_inputXXX_max_chars = 3
Global Const $gui_inputXXX_max_input = 999
Global Const $gui_inputXXX_min_input = 0
Global Const $gui_inputXXX_style = BitOR($GUI_SS_DEFAULT_INPUT, $ES_NUMBER)

Global Const $gui_dropdown_style = BitOR($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST)

Global Const $gui_inputRO_width = 155
Global Const $gui_inputRO_style = BitOR($GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_CENTER)
Global Const $gui_inputRO_text[2] = ["UNKNOWN", "CALIBRATED"]
Global Const $gui_inputRO_color[2] = [0xff4040, 0x40ff40]

Global Const $gui_group_p1_element_x = $gui_group_margin_outer_side + $gui_group_margin_inner_side
Global Const $gui_group_p2_element_x = $gui_group_p1_element_x + $gui_group_tab_inner
Global Const $gui_group_ctrl_x = $gui_group_p2_element_x + 200

Global Const $gui_menu_height = 20


;----------------------------------------------------------------------
; main window
;----------------------------------------------------------------------
Global Const $gui_main_width = 600

;----------------------------------------------------------------------
; collection group
;----------------------------------------------------------------------
Global Const $gui_group_collection_title = "Collection"
Global Const $gui_group_collection_x = $gui_group_margin_outer_side
Global Const $gui_group_collection_y = $gui_group_margin_outer_top
Global Const $gui_group_collection_width = $gui_main_width - 2*$gui_group_margin_outer_side


;elements start here
Global Const $gui_group_collection_label_class_cards_text = "Class cards:"
Global Const $gui_group_collection_label_class_cards_x = $gui_group_p1_element_x
Global Const $gui_group_collection_label_class_cards_y = $gui_group_collection_y + $gui_group_margin_inner_top

Global Const $gui_group_collection_label_page_count_text = "total number of pages: "
Global Const $gui_group_collection_label_page_count_x = $gui_group_p2_element_x
Global Const $gui_group_collection_label_page_count_y1 = $gui_group_collection_label_class_cards_y + $gui_group_margin_inner_top

Global Const $gui_group_collection_input_page_count_x = $gui_group_ctrl_x
Global Const $gui_group_collection_input_page_count_y1 = $gui_group_collection_label_page_count_y1
Global Const $gui_group_collection_input_page_count_width = $gui_inputXXX_width
Global Const $gui_group_collection_input_page_count_height = -1 ;use label height


Global Const $gui_group_collection_label_page_tail_text = "cards on the last page: "
Global Const $gui_group_collection_label_page_tail_x = $gui_group_p2_element_x
Global Const $gui_group_collection_label_page_tail_y1 = $gui_group_collection_label_page_count_y1 + $gui_group_margin_inner_top

Global Const $gui_group_collection_label_radio[8] = ["1", "2", "3", "4", _
                                                     "5", "6", "7", "8"]
Global Const $gui_group_collection_radio_x = $gui_group_ctrl_x
Global Const $gui_group_collection_radio_dx = 40
Global Const $gui_group_collection_radio_y1 = $gui_group_collection_label_page_tail_y1
Global Const $gui_group_collection_radio_dy = $gui_group_margin_inner_top




Global Const $gui_group_collection_label_overall_cards_text = "Overall cards:"
Global Const $gui_group_collection_label_overall_cards_x = $gui_group_p1_element_x
Global Const $gui_group_collection_label_overall_cards_y = $gui_group_collection_radio_y1 + $gui_group_collection_radio_dy _ 
                                                            + $gui_group_gap_inner

Global Const $gui_group_collection_label_page_count_y2 = $gui_group_collection_label_overall_cards_y + $gui_group_margin_inner_top
Global Const $gui_group_collection_input_page_count_y2 = $gui_group_collection_label_page_count_y2
Global Const $gui_group_collection_label_page_tail_y2 = $gui_group_collection_label_page_count_y2 + $gui_group_margin_inner_top
Global Const $gui_group_collection_radio_y2 = $gui_group_collection_label_page_tail_y2

Global Const $gui_group_collection_height = $gui_group_collection_radio_y2 + $gui_group_collection_radio_dy - $gui_group_collection_y _
                                            + $gui_group_margin_inner_top


;----------------------------------------------------------------------
; calibration group
;----------------------------------------------------------------------
Global Const $gui_group_calibration_title = "Calibration"
Global Const $gui_group_calibration_x = $gui_group_margin_outer_side
Global Const $gui_group_calibration_y = $gui_group_collection_y + $gui_group_collection_height _
                                        + $gui_group_margin_outer_bot + $gui_group_margin_outer_top
Global Const $gui_group_calibration_width = $gui_main_width - 2*$gui_group_margin_outer_side
 

Global Const $gui_group_calibration_label_card0_title = "Top left card position: "
Global Const $gui_group_calibration_label_card0_x = $gui_group_p1_element_x
Global Const $gui_group_calibration_label_card0_y = $gui_group_calibration_y + $gui_group_margin_inner_top

Global Const $gui_group_calibration_input_card0_x = $gui_group_ctrl_x
Global Const $gui_group_calibration_input_card0_y = $gui_group_calibration_label_card0_y
Global Const $gui_group_calibration_input_card0_width = $gui_inputRO_width
Global Const $gui_group_calibration_input_card0_height = -1 ;use label height

Global Const $gui_group_calibration_label_card7_title = "Bottom right card position: "
Global Const $gui_group_calibration_label_card7_x = $gui_group_p1_element_x
Global Const $gui_group_calibration_label_card7_y = $gui_group_calibration_label_card0_y + $gui_group_margin_inner_top

Global Const $gui_group_calibration_input_card7_x = $gui_group_ctrl_x
Global Const $gui_group_calibration_input_card7_y = $gui_group_calibration_label_card7_y
Global Const $gui_group_calibration_input_card7_width = $gui_inputRO_width
Global Const $gui_group_calibration_input_card7_height = -1 ;use label height

Global Const $gui_group_calibration_label_nextPage_title = '"Next page" button postion: '
Global Const $gui_group_calibration_label_nextPage_x = $gui_group_p1_element_x
Global Const $gui_group_calibration_label_nextPage_y = $gui_group_calibration_label_card7_y + $gui_group_margin_inner_top

Global Const $gui_group_calibration_input_nextPage_x = $gui_group_ctrl_x
Global Const $gui_group_calibration_input_nextPage_y = $gui_group_calibration_label_nextPage_y
Global Const $gui_group_calibration_input_nextPage_width = $gui_inputRO_width
Global Const $gui_group_calibration_input_nextPage_height = -1 ;use label height

Global Const $gui_group_calibration_label_done_title = '"Done" button position: '
Global Const $gui_group_calibration_label_done_x = $gui_group_p1_element_x
Global Const $gui_group_calibration_label_done_y = $gui_group_calibration_label_nextPage_y + $gui_group_margin_inner_top

Global Const $gui_group_calibration_input_done_x = $gui_group_ctrl_x
Global Const $gui_group_calibration_input_done_y = $gui_group_calibration_label_done_y
Global Const $gui_group_calibration_input_done_width = $gui_inputRO_width
Global Const $gui_group_calibration_input_done_height = -1 ;use label height

Global Const $gui_group_calibration_height = $gui_group_calibration_input_done_y - $gui_group_calibration_y _
                                            + $gui_group_margin_inner_top 

Global Const $gui_main_height = $gui_group_calibration_y + $gui_group_calibration_height + $gui_group_margin_outer_bot + $gui_menu_height


;----------------------------------------------------------------------
; GUI methods
;----------------------------------------------------------------------
Func GUI_Init()
    Opt("GUIOnEventMode", 1) ; Change to OnEvent mode
    
    Local $handle_main = GUICreate("Random Deck Generator", $gui_main_width, $gui_main_height)
    GUISetFont(14)
    
    
    GUICtrlCreateGroup($gui_group_collection_title, $gui_group_collection_x, $gui_group_collection_y, _
        $gui_group_collection_width, $gui_group_collection_height)
        
    
    GUICtrlCreateLabel($gui_group_collection_label_class_cards_text, _
        $gui_group_collection_label_class_cards_x, _
        $gui_group_collection_label_class_cards_y)

    GUICtrlCreateLabel($gui_group_collection_label_page_count_text, _
        $gui_group_collection_label_page_count_x, _
        $gui_group_collection_label_page_count_y1)
    
    $gui_ctrlId_class_page_count = GUICtrlCreateInput(0, _
        $gui_group_collection_input_page_count_x, _
        $gui_group_collection_input_page_count_y1, _
        $gui_group_collection_input_page_count_width, _
        $gui_group_collection_input_page_count_height, _
        $gui_inputXXX_style)

    GUICtrlSetLimit(-1, $gui_inputXXX_max_chars)
    GUICtrlCreateUpdown(-1)
    GUICtrlSetLimit(-1, $gui_inputXXX_max_input, $gui_inputXXX_min_input)
    
    GUICtrlCreateLabel($gui_group_collection_label_page_tail_text, _
        $gui_group_collection_label_page_tail_x, _
        $gui_group_collection_label_page_tail_y1)
    
    GUIStartGroup()
    For $i=0 To 7 
        $gui_ctrlId_class_tail_count[$i] = GUICtrlCreateRadio($gui_group_collection_label_radio[$i], _
            $gui_group_collection_radio_x + $gui_group_collection_radio_dx * (($i>3) ? $i-4 : $i), _
            $gui_group_collection_radio_y1 + $gui_group_collection_radio_dy * (($i>3) ? 1 : 0), _
            $gui_group_collection_radio_dx, _
            -1)
    Next

    GUICtrlCreateLabel($gui_group_collection_label_overall_cards_text, _
        $gui_group_collection_label_overall_cards_x, _
        $gui_group_collection_label_overall_cards_y)
    
    
    GUICtrlCreateLabel($gui_group_collection_label_page_count_text, _
        $gui_group_collection_label_page_count_x, _
        $gui_group_collection_label_page_count_y2)
    
    $gui_ctrlId_overall_page_count = GUICtrlCreateInput(0, _
        $gui_group_collection_input_page_count_x, _
        $gui_group_collection_input_page_count_y2, _
        $gui_group_collection_input_page_count_width, _
        $gui_group_collection_input_page_count_height, _
        $gui_inputXXX_style)

    GUICtrlSetLimit(-1, $gui_inputXXX_max_chars)
    GUICtrlCreateUpdown(-1)
    GUICtrlSetLimit(-1, $gui_inputXXX_max_input, $gui_inputXXX_min_input)
    
    GUICtrlCreateLabel($gui_group_collection_label_page_tail_text, _
        $gui_group_collection_label_page_tail_x, _
        $gui_group_collection_label_page_tail_y2)
    
    GUIStartGroup()
    For $i=0 To 7 
        $gui_ctrlId_overalll_tail_count[$i] = GUICtrlCreateRadio($gui_group_collection_label_radio[$i], _
            $gui_group_collection_radio_x + $gui_group_collection_radio_dx * (($i>3) ? $i-4 : $i), _
            $gui_group_collection_radio_y2 + $gui_group_collection_radio_dy * (($i>3) ? 1 : 0), _
            $gui_group_collection_radio_dx, _
            -1)
    Next


    GUICtrlCreateGroup($gui_group_calibration_title, $gui_group_calibration_x, $gui_group_calibration_y, _
        $gui_group_calibration_width, $gui_group_calibration_height)
        
    GUICtrlCreateLabel($gui_group_calibration_label_card0_title, _
        $gui_group_calibration_label_card0_x, _
        $gui_group_calibration_label_card0_y)
    
    $gui_ctrlId_calibration[$gui_ctrl_card0] = GUICtrlCreateInput($gui_inputRO_text[0], _
        $gui_group_calibration_input_card0_x, _
        $gui_group_calibration_input_card0_y, _
        $gui_group_calibration_input_card0_width, _
        $gui_group_calibration_input_card0_height, _
        $gui_inputRO_style)
    GUICtrlSetBkColor(-1, $gui_inputRO_color[0])
    
    
    GUICtrlCreateLabel($gui_group_calibration_label_card7_title, _
        $gui_group_calibration_label_card7_x, _
        $gui_group_calibration_label_card7_y)
    
    $gui_ctrlId_calibration[$gui_ctrl_card7] = GUICtrlCreateInput($gui_inputRO_text[0], _
        $gui_group_calibration_input_card7_x, _
        $gui_group_calibration_input_card7_y, _
        $gui_group_calibration_input_card7_width, _
        $gui_group_calibration_input_card7_height, _
        $gui_inputRO_style)
    GUICtrlSetBkColor(-1, $gui_inputRO_color[0])
    
    GUICtrlCreateLabel($gui_group_calibration_label_nextPage_title, _
        $gui_group_calibration_label_nextPage_x, _
        $gui_group_calibration_label_nextPage_y)
    
    $gui_ctrlId_calibration[$gui_ctrl_nextPage] = GUICtrlCreateInput($gui_inputRO_text[0], _
        $gui_group_calibration_input_nextPage_x, _
        $gui_group_calibration_input_nextPage_y, _
        $gui_group_calibration_input_nextPage_width, _
        $gui_group_calibration_input_nextPage_height, _
        $gui_inputRO_style)
    GUICtrlSetBkColor(-1, $gui_inputRO_color[0])
    
    GUICtrlCreateLabel($gui_group_calibration_label_done_title, _
        $gui_group_calibration_label_done_x, _
        $gui_group_calibration_label_done_y)
    
    $gui_ctrlId_calibration[$gui_ctrl_deckDone] = GUICtrlCreateInput($gui_inputRO_text[0], _
        $gui_group_calibration_input_done_x, _
        $gui_group_calibration_input_done_y, _
        $gui_group_calibration_input_done_width, _
        $gui_group_calibration_input_done_height, _
        $gui_inputRO_style)
    GUICtrlSetBkColor(-1, $gui_inputRO_color[0])
    
    
    $gui_ctrlId_menu_info = GUICtrlCreateMenu("Info")
    $gui_ctrlId_menu_help = GUICtrlCreateMenu("Help", $gui_ctrlId_menu_info)
    $gui_ctrlId_menuItem_about = GUICtrlCreateMenuItem("About", $gui_ctrlId_menu_info)
    $gui_ctrlId_menuItem_lic = GUICtrlCreateMenuItem("License", $gui_ctrlId_menu_info)
    
    $gui_ctrlId_menu_help_intro = GUICtrlCreateMenuItem("Introduction", $gui_ctrlId_menu_help)
    $gui_ctrlId_menu_help_basics = GUICtrlCreateMenuItem("Basics", $gui_ctrlId_menu_help)
    $gui_ctrlId_menu_help_instr1 = GUICtrlCreateMenuItem("Instructions: calibrate controls", $gui_ctrlId_menu_help)
    $gui_ctrlId_menu_help_instr2 = GUICtrlCreateMenuItem("Instructions: generate deck", $gui_ctrlId_menu_help)
    
    GUICtrlSetOnEvent($gui_ctrlId_menuItem_about, "GUI_OnInfo")
    GUICtrlSetOnEvent($gui_ctrlId_menuItem_lic, "GUI_OnInfo")
    
    GUICtrlSetOnEvent($gui_ctrlId_menu_help_intro, "GUI_OnInfo")
    GUICtrlSetOnEvent($gui_ctrlId_menu_help_basics, "GUI_OnInfo")
    GUICtrlSetOnEvent($gui_ctrlId_menu_help_instr1, "GUI_OnInfo")
    GUICtrlSetOnEvent($gui_ctrlId_menu_help_instr2, "GUI_OnInfo")
    
EndFunc

Func GUI_Show()
    GUISetState(@SW_SHOW)
EndFunc

;switches state of calibration indication controles by their enumeration
Func GUI_CalibrationStateChange($enum_control, $state)
    GUICtrlSetData($gui_ctrlId_calibration[$enum_control], $gui_inputRO_text[$state])
    GUICtrlSetBkColor($gui_ctrlId_calibration[$enum_control], $gui_inputRO_color[$state])
EndFunc

Func GUI_ClassPageCountGet()
    Return Number(GUICtrlRead($gui_ctrlId_class_page_count))
EndFunc

Func GUI_OverallPageCountGet()
    Return Number(GUICtrlRead($gui_ctrlId_overall_page_count))
EndFunc

Func GUI_ClassPageCountSet($value)
    GUICtrlSetData($gui_ctrlId_class_page_count, $value)
EndFunc

Func GUI_OverallPageCountSet($value)
    GUICtrlSetData($gui_ctrlId_overall_page_count, $value)
EndFunc


Func GUI_ClassTailCountGet()
    For $i=0 to 7 
        If GUICtrlRead($gui_ctrlId_class_tail_count[$i]) == $GUI_CHECKED Then
            Return $i + 1
        EndIf
    Next
    Return SetError(1, 0, -1)
EndFunc

Func GUI_OverallTailCountGet()
    For $i=0 to 7 
        If GUICtrlRead($gui_ctrlId_overalll_tail_count[$i]) == $GUI_CHECKED Then
            Return $i + 1
        EndIf
    Next
    Return SetError(1, 0, -1)
EndFunc

Func GUI_ClassTailCountSet($value)
    If $value >= 1 AND $value <=8 Then
        GUICtrlSetState($gui_ctrlId_class_tail_count[$value-1], $GUI_CHECKED)
    Else
        Return SetError(1, 0, -1)
    EndIf
EndFunc

Func GUI_OverallTailCountSet($value)
    If $value >= 1 AND $value <=8 Then
        GUICtrlSetState($gui_ctrlId_overalll_tail_count[$value-1], $GUI_CHECKED)
    Else
        Return SetError(1, 0, -1)
    EndIf
EndFunc


Func GUI_ClassPageCountCbRegister($cb_name)
    GUICtrlSetOnEvent($gui_ctrlId_class_page_count, $cb_name)
EndFunc

Func GUI_ExitCbRegister($cb_name)
    GUISetOnEvent($GUI_EVENT_CLOSE, $cb_name)
EndFunc

Func GUI_OnInfo()
    Select
        Case @GUI_CtrlId = $gui_ctrlId_menuItem_lic
            MsgBox($MB_OK, "License", $RES_license)
        Case @GUI_CtrlId = $gui_ctrlId_menuItem_about
            MsgBox($MB_OK, "About", $RES_about)
        Case @GUI_CtrlId = $gui_ctrlId_menu_help_intro
            MsgBox($MB_OK, "Help", $RES_help_intro)
        Case @GUI_CtrlId = $gui_ctrlId_menu_help_basics
            MsgBox($MB_OK, "Help", $RES_help_basics)
        Case @GUI_CtrlId = $gui_ctrlId_menu_help_instr1
            MsgBox($MB_OK, "Help", $RES_help_instr1)
        Case @GUI_CtrlId = $gui_ctrlId_menu_help_instr2
            MsgBox($MB_OK, "Help", $RES_help_instr2)
            
    EndSelect
EndFunc
