;-----------------------------------------
; Mac keyboard to Windows Key Mappings
;=========================================

; --------------------------------------------------------------
; NOTES
; --------------------------------------------------------------
; ! = ALT
; ^ = CTRL
; + = SHIFT
; # = WIN
;
; Debug action snippet: MsgBox You pressed Control-A while Notepad is active.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CapsLock::CTRL
#BS::
    if WinActive("ahk_exe explorer.exe")
        Send {Del} ; Win+Backspace deletes files in Explorer
    else
        Send {LShift down}{Home}{LShift Up}{Backspace} ; Win+Backspace deletes whole line
    return

^q::Send !{F4}

#SingleInstance, Force


; Copy, paste, cut
#c::
Send, ^c
Return

#v::
Send, ^v
Return

#x::
Send, ^x
Return

; New, Save, Open
#n::
Send, ^n
Return

#+n::
Send, ^+n

#s::
Send, ^s
Return

#o::
Send, ^o
Return

; Browser tabs
#t::
Send, ^t
Return

#w::
Send, ^w
Return

#+t::
Send, ^+T
Return

#r::
Send, ^r
Return

; Select all
#a::
Send, ^a
Return

; Home/end
#Right::
Send, {End}
Return

#Left::
Send, {Home}
Return

; Select to end/select to beginning
#+Right::
Send, +{End}
Return

#+Left::
Send, +{Home}
Return

; Undo/redo
#z::
Send, ^z
Return

#+z::
Send, ^+z
Return

; Find, find next
#f::
Send, ^f
Return

; Find, find next
#+f::
Send, ^+f
Return

#g::
Send, ^g
Return

; Text formatting (bold, italic, etc)
#b::
Send, ^b
Return

#i::
Send, ^i
Return

#u::
Send, ^u
Return

#k::
Send, ^k
Return

; Send/line break
#Enter::
Send, ^{Enter}
Return

; 1Password browser shortcut
#\::
Send, ^\
Return

#l::
Send, ^l
Return

^+l::
Send, #l
Return


; Quick Switch Tab shotcuts

$!1::Send ^1
$!2::Send ^2
$!3::Send ^3
$!4::Send ^4
$!5::Send ^5
$!6::Send ^6
$!7::Send ^7
$!8::Send ^8
$!9::Send ^9
$!0::Send ^0

#p::
    if WinActive("ahk_exe code.exe")
        Send ^p
    return

#+p::
    if WinActive("ahk_exe code.exe")
        Send ^+p
    return