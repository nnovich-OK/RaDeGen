#include-once

#cs

#ce

Global Const $fm_config_filename = "config.ini"

Global Const $fm_preset_name_custom[1] = ["Custom"]
Global Const $fm_preset_name_class[9] = ["druid", "hunter", "mage", "paladin", "priest", "rogue", "shaman", "warlock", "warrior"]
Global Const $fm_preset_name_mode[2] = ["Wild", "Standard"]
Global $fm_preset_names[0]
Global $fm_preset_default


Global Const $fm_class_page_count_def = 1
Global Const $fm_class_tail_count_def = 5 ; newcomers have 5 cards for each class
Global Const $fm_neutral_page_count_def = 6
Global Const $fm_neutral_tail_count_def = 3 ; newcomers have 43 neutral cards: 6 pages with 3 cards on the last one

Func FM_Init()
	FM_PresetNamesGenerate()
EndFunc

Func FM_PresetNamesGenerate()
	For $name In $fm_preset_name_custom
		FM_PresetNameAdd($name)
	Next
	
	For $mode_name In $fm_preset_name_mode
		For $class_name In $fm_preset_name_class
			FM_PresetNameAdd($mode_name & " " &$class_name)
		Next
	Next
	
	$fm_preset_default = $fm_preset_names[0]
EndFunc

Func FM_PresetNameAdd($name)
	Static Local $fm_preset_name_counter = 0
	$fm_preset_name_counter += 1
	ReDim $fm_preset_names[$fm_preset_name_counter]
	$fm_preset_names[$fm_preset_name_counter - 1] = $name
EndFunc

Func FM_PresetNamesGet()
	Return $fm_preset_names
EndFunc

Func FM_PresetDefaultGet()
	Return $fm_preset_default
EndFunc

Func FM_CollectionStateSave($preset, _
		$class_page_count, $class_tail_count, _
		$neutral_page_count, $neutral_tail_count)
		
	IniWrite($fm_config_filename, $preset, "class_page_count", $class_page_count)
	IniWrite($fm_config_filename, $preset, "class_tail_count", $class_tail_count)
	
	Local $mode = FM_PresetModeGet($preset)
	IniWrite($fm_config_filename, $mode, "neutral_page_count", $neutral_page_count)
	IniWrite($fm_config_filename, $mode, "neutral_tail_count", $neutral_tail_count)
		
EndFunc

; updates variables for chosen preset
; if no preset provided, default one is used
; TODO: should I spend time on $preset verification?
Func FM_CollectionStateLoad(ByRef $preset, _
		ByRef $class_page_count, ByRef $class_tail_count, _
		ByRef $neutral_page_count, ByRef $neutral_tail_count)

	If $preset = "" Then
		$preset = $fm_preset_default
	EndIf
	
	$class_page_count = Number(IniRead($fm_config_filename, $preset, "class_page_count", $fm_class_page_count_def))
	$class_tail_count = Number(IniRead($fm_config_filename, $preset, "class_tail_count", $fm_class_tail_count_def))
	
	Local $mode = FM_PresetModeGet($preset)
	$neutral_page_count = Number(IniRead($fm_config_filename, $mode, "neutral_page_count", $fm_neutral_page_count_def))
	$neutral_tail_count = Number(IniRead($fm_config_filename, $mode, "neutral_tail_count", $fm_neutral_tail_count_def))
EndFunc


;custom preset saves all data in one section
;other presets are splitted, since neutral cards are share among several presets
;e.g. "wild priest" saves class cards into [wild priest] section, while neutral cards into [wild] section
Func FM_PresetModeGet($preset)
	Local $is_custom_preset = false
	For $tmp_preset_name In $fm_preset_name_custom
		If $tmp_preset_name = $preset Then
			$is_custom_preset = true
			ExitLoop
		EndIf
	Next
	Return (($is_custom_preset) ? $preset : StringSplit($preset, " ")[1])
EndFunc


Func FM_CalibrationStateSave(Const ByRef $calibration_card0_pos, _
		Const ByRef $calibration_card7_pos, _
		Const ByRef $calibration_button_nextPage_pos, _
		Const ByRef $calibration_button_deckDone_pos)
		
	IniWrite($fm_config_filename, "Calibration", "card0_pos_x", $calibration_card0_pos[0])
	IniWrite($fm_config_filename, "Calibration", "card0_pos_y", $calibration_card0_pos[1])

	IniWrite($fm_config_filename, "Calibration", "card7_pos_x", $calibration_card7_pos[0])
	IniWrite($fm_config_filename, "Calibration", "card7_pos_y", $calibration_card7_pos[1])
	
	IniWrite($fm_config_filename, "Calibration", "button_nextPage_pos_x", $calibration_button_nextPage_pos[0])
	IniWrite($fm_config_filename, "Calibration", "button_nextPage_pos_y", $calibration_button_nextPage_pos[1])
	
	IniWrite($fm_config_filename, "Calibration", "button_deckDone_pos_x", $calibration_button_deckDone_pos[0])
	IniWrite($fm_config_filename, "Calibration", "button_deckDone_pos_y", $calibration_button_deckDone_pos[1])
EndFunc

Func FM_CalibrationStateLoad(ByRef $calibration_card0_pos, _
		ByRef $calibration_card7_pos, _
		ByRef $calibration_button_nextPage_pos, _
		ByRef $calibration_button_deckDone_pos)

	$calibration_card0_pos[0] = Number(IniRead($fm_config_filename, "Calibration", "card0_pos_x", 0))
	$calibration_card0_pos[1] = Number(IniRead($fm_config_filename, "Calibration", "card0_pos_y", 0))
	
	$calibration_card7_pos[0] = Number(IniRead($fm_config_filename, "Calibration", "card7_pos_x", 0))
	$calibration_card7_pos[1] = Number(IniRead($fm_config_filename, "Calibration", "card7_pos_y", 0))
	
	$calibration_button_nextPage_pos[0] = Number(IniRead($fm_config_filename, "Calibration", "button_nextPage_pos_x", 0))
	$calibration_button_nextPage_pos[1] = Number(IniRead($fm_config_filename, "Calibration", "button_nextPage_pos_y", 0))
	
	$calibration_button_deckDone_pos[0] = Number(IniRead($fm_config_filename, "Calibration", "button_deckDone_pos_x", 0))
	$calibration_button_deckDone_pos[1] = Number(IniRead($fm_config_filename, "Calibration", "button_deckDone_pos_y", 0))
EndFunc