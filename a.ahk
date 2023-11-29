^NumPad9::
run, "Notepad++.exe"
return

^NumPad2::
Run,https://www.youtube.com
return

^NumPad1::
Run,https://google.com
return

^Numpad3::
Run,https://chat.openai.com
return

^Numpad4::
Run,http://localhost:8069
return

^Numpad5::
Run,http://localhost:8070
return


;----------------------------------------------------------------------------
;Volume control, Alt+Scroll wheel (and Mbutton)

Alt & WheelUp::Volume_Up
Alt & WheelDown::Volume_Down
Alt & MButton::Volume_Mute

google(service := 1)
{9
    static urls := { 0: ""
        , 1 : "https://www.google.com/search?hl=en&q="
        , 2 : "https://www.google.com/search?site=imghp&tbm=isch&q="
        , 3 : "https://www.google.com/maps/search/"
        , 4 : "https://translate.google.com/?sl=auto&tl=en&text=" 
	, 5 : "https://en.wikipedia.org/wiki/Special:Search?search=" }
    backup := ClipboardAll
    Clipboard := ""
    Send ^c
    ClipWait 0
    if ErrorLevel
        InputBox query, Google Search,,, 200, 100
    else query := Clipboard
    Run % urls[service] query
    Clipboard := backup
}

F1::google(1) ; Regular search
F2::google(2) ; Images search
F3::google(3) ; Maps search
F4::google(4) ; Translation
F5::google(5) ; Wiki search


!Capslock::
    Click, Down, Right 
    While GetKeyState("Capslock", "P") 
        Sleep 10 
    Click, Up, Right 
Return	

Capslock::
    Click, Down, Left 
    While GetKeyState("Capslock", "P") 
        Sleep 10 
    Click, Up, Left 
Return				

+Capslock::Capslock ; shift + caplocks

; #Include E:\ahk\VA.ahk
#Include VA.ahk

F6::  ; F1 hotkey - toggle mute state of active window
  WinGet, ActivePid, PID, A
  if !(Volume := GetVolumeObject(ActivePid))
    MsgBox, There was a problem retrieving the application volume interface
  VA_ISimpleAudioVolume_GetMute(Volume, Mute)  ;Get mute state
  ; Msgbox % "Application " ActivePID " is currently " (mute ? "muted" : "not muted")
  VA_ISimpleAudioVolume_SetMute(Volume, !Mute) ;Toggle mute state
  ObjRelease(Volume)
return



; release the memory of private working set of all running processes in every hour.


Settimer, ReleaseMemory, % 1000 * 60 * 60 

ReleaseMemory:
    for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process") {
        handle := DllCall("OpenProcess", "UInt", 0x001F0FFF, "Int", 0, "Int", process.ProcessID)
        DllCall("SetProcessWorkingSetSize", "UInt", handle, "Int", -1, "Int", -1)
        DllCall("CloseHandle", "Int", handle)
    }
Return

^!r::reload ; Ctrl-Alt-R: Reload AHK script


#q:: ; Win+O is the shortcut; you can change it to your preferred shortcut
Run, "C:\Users\Admin\AppData\Local\Programs\Microsoft VS Code" ; Replace with the path to your VSCode executable
WinWaitActive, ahk_exe Code.exe
return
