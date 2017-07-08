#include-once

#cs

#ce

Global Const $fm_config_filename = "config.ini"

Global Const $fm_secname_calibration = "Calibration"
Global Const $fm_secname_collection = "Collection"

Global Const $fm_class_page_count_def = 1
Global Const $fm_class_tail_count_def = 5 ; newcomers have 5 cards for each class
Global Const $fm_neutral_page_count_def = 6
Global Const $fm_neutral_tail_count_def = 3 ; newcomers have 43 neutral cards: 6 pages with 3 cards on the last one


Func FM_CollectionStateSave( _
        $class_page_count, $class_tail_count, _
        $neutral_page_count, $neutral_tail_count)
        
    IniWrite($fm_config_filename, $fm_secname_collection, "class_page_count", $class_page_count)
    IniWrite($fm_config_filename, $fm_secname_collection, "class_tail_count", $class_tail_count)
    IniWrite($fm_config_filename, $fm_secname_collection, "neutral_page_count", $neutral_page_count)
    IniWrite($fm_config_filename, $fm_secname_collection, "neutral_tail_count", $neutral_tail_count)
        
EndFunc


Func FM_CollectionStateLoad( _
        ByRef $class_page_count, ByRef $class_tail_count, _
        ByRef $neutral_page_count, ByRef $neutral_tail_count)

    $class_page_count = Number(IniRead($fm_config_filename, $fm_secname_collection, "class_page_count", $fm_class_page_count_def))
    $class_tail_count = Number(IniRead($fm_config_filename, $fm_secname_collection, "class_tail_count", $fm_class_tail_count_def))
    
    $neutral_page_count = Number(IniRead($fm_config_filename, $fm_secname_collection, "neutral_page_count", $fm_neutral_page_count_def))
    $neutral_tail_count = Number(IniRead($fm_config_filename, $fm_secname_collection, "neutral_tail_count", $fm_neutral_tail_count_def))
EndFunc


Func FM_CalibrationStateSave( _
        Const ByRef $calibration_card0_pos, _
        Const ByRef $calibration_card7_pos, _
        Const ByRef $calibration_button_nextPage_pos, _
        Const ByRef $calibration_button_deckDone_pos)
        
    IniWrite($fm_config_filename, $fm_secname_calibration, "card0_pos_x", $calibration_card0_pos[0])
    IniWrite($fm_config_filename, $fm_secname_calibration, "card0_pos_y", $calibration_card0_pos[1])

    IniWrite($fm_config_filename, $fm_secname_calibration, "card7_pos_x", $calibration_card7_pos[0])
    IniWrite($fm_config_filename, $fm_secname_calibration, "card7_pos_y", $calibration_card7_pos[1])
    
    IniWrite($fm_config_filename, $fm_secname_calibration, "button_nextPage_pos_x", $calibration_button_nextPage_pos[0])
    IniWrite($fm_config_filename, $fm_secname_calibration, "button_nextPage_pos_y", $calibration_button_nextPage_pos[1])
    
    IniWrite($fm_config_filename, $fm_secname_calibration, "button_deckDone_pos_x", $calibration_button_deckDone_pos[0])
    IniWrite($fm_config_filename, $fm_secname_calibration, "button_deckDone_pos_y", $calibration_button_deckDone_pos[1])
EndFunc

Func FM_CalibrationStateLoad( _
        ByRef $calibration_card0_pos, _
        ByRef $calibration_card7_pos, _
        ByRef $calibration_button_nextPage_pos, _
        ByRef $calibration_button_deckDone_pos)

    $calibration_card0_pos[0] = Number(IniRead($fm_config_filename, $fm_secname_calibration, "card0_pos_x", 0))
    $calibration_card0_pos[1] = Number(IniRead($fm_config_filename, $fm_secname_calibration, "card0_pos_y", 0))
    
    $calibration_card7_pos[0] = Number(IniRead($fm_config_filename, $fm_secname_calibration, "card7_pos_x", 0))
    $calibration_card7_pos[1] = Number(IniRead($fm_config_filename, $fm_secname_calibration, "card7_pos_y", 0))
    
    $calibration_button_nextPage_pos[0] = Number(IniRead($fm_config_filename, $fm_secname_calibration, "button_nextPage_pos_x", 0))
    $calibration_button_nextPage_pos[1] = Number(IniRead($fm_config_filename, $fm_secname_calibration, "button_nextPage_pos_y", 0))
    
    $calibration_button_deckDone_pos[0] = Number(IniRead($fm_config_filename, $fm_secname_calibration, "button_deckDone_pos_x", 0))
    $calibration_button_deckDone_pos[1] = Number(IniRead($fm_config_filename, $fm_secname_calibration, "button_deckDone_pos_y", 0))
EndFunc