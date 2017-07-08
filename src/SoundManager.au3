#include-once
;probably will include audio files of my own

Func SM_NotifySuccess()
    SoundPlay(@WindowsDir & "\media\Windows Balloon.wav", 0)
EndFunc

Func SM_NotifyFailure()
    SoundPlay(@WindowsDir & "\media\Windows Error.wav", 0)
EndFunc

Func SM_NotifyLongTaskFinished()
    SoundPlay(@WindowsDir & "\media\Windows Balloon.wav", 0)
EndFunc

Func SM_NotifyLongTaskHalted()
    SoundPlay(@WindowsDir & "\media\Windows Error.wav", 0)
EndFunc