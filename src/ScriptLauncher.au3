#include-once

#cs
Script launcher (SL) is intended to separate code responsible
for launching, halting and trackign state of scripts invoked by hotkeys.

The main purposes:
 - allow "halt hotkey" to break currently running script
 - disallow any other hotkey script to interrupt currently running one
#ce

Func SL_Init()
    Global $script_flag_stop = false
    Global $script_flag_running = false
    Global $script_func_ptr = Null
EndFunc


; pends script assignement, then executes it
Func SL_ScriptLaunch()
    While $script_func_ptr = Null
        Sleep(100)
    WEnd
    
    $script_flag_stop = false   ; clear stop flag
    
    $script_flag_running = true ; set running flag
    $script_func_ptr()
    
    ;reset flags for waiting state
    $script_func_ptr = Null
    $script_flag_running = false
EndFunc


Func SL_ScriptAssign($ptr)
    $script_func_ptr = $ptr
EndFunc


Func SL_ScriptHalt()
    $script_flag_stop = true
EndFunc

; should be polled by script to know time to stop
Func SL_QueryStopFlag()
    return $script_flag_stop
EndFunc

Func SL_QueryRunningFlag()
    return $script_flag_running
EndFunc
