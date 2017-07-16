#include-once
;probably will include audio files of my own

Global $SM_audio_enabled = 0

Func SM_AudioEnable($enable)
    $SM_audio_enabled = $enable
EndFunc

Func SM_NotifySuccess()
    If $SM_audio_enabled Then
        SoundPlay(@WindowsDir & "\media\Windows Balloon.wav", 0)
    EndIf
EndFunc

Func SM_NotifyFailure()
    If $SM_audio_enabled Then
        SoundPlay(@WindowsDir & "\media\Windows Error.wav", 0)
    EndIf
EndFunc

Func SM_NotifyLongTaskFinished()
    If $SM_audio_enabled Then
        SoundPlay(@WindowsDir & "\media\Windows Balloon.wav", 0)
    EndIf
EndFunc

Func SM_NotifyLongTaskHalted()
    If $SM_audio_enabled Then
        SoundPlay(@WindowsDir & "\media\Windows Error.wav", 0)
    EndIf
EndFunc