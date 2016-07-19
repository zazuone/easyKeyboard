#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;=====================================================================o
;                   Feng Ruohang's AHK Script                         | 
;                      CapsLock Enhancement                           |
;---------------------------------------------------------------------o
;Description:                                                         |
;    This Script is wrote by Feng Ruohang via AutoHotKey Script. It   |
; Provieds an enhancement towards the "Useless Key" CapsLock, and     |
; turns CapsLock into an useful function Key just like Ctrl and Alt   |
; by combining CapsLock with almost all other keys in the keyboard.   |
;                                                                     |
;Summary:                                                             |
;o----------------------o---------------------------------------------o
;|CapsLock;             | {ESC}  Especially Convient for vim user     |
;|CaspLock + `          | {CapsLock}CapsLock Switcher as a Substituent|
;|CapsLock + hjklwb     | Vim-Style Cursor Mover                      |
;|CaspLock + uiop       | Convient Home/End PageUp/PageDn             |
;|CaspLock + nm,.       | Convient Delete Controller                  |
;|CapsLock + zxcvay     | Windows-Style Editor                        |
;|CapsLock + Direction  | Mouse Move                                  |
;|CapsLock + Enter      | Mouse Click                                 |
;|CaspLock + {F1}!{F7}  | Media Volume Controller                     |
;|CapsLock + qs         | Windows & Tags Control                      |
;|CapsLock + ;'[]       | Convient Key Mapping                        |
;|CaspLock + dfert      | Frequently Used Programs (Self Defined)     |
;|CaspLock + 123456     | Dev-Hotkey for Visual Studio (Self Defined) |
;|CapsLock + 67890-=    | Shifter as Shift                            |
;-----------------------o---------------------------------------------o
;|Use it whatever and wherever you like. Hope it help                 |
;=====================================================================o


;=====================================================================o
;                       CapsLock Initializer                         ;|
;---------------------------------------------------------------------o
SetCapsLockState, AlwaysOff                                          ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                       CapsLock Switcher:                           ;|
;---------------------------------o-----------------------------------o
;                    CapsLock + ` | {CapsLock}                       ;|
;---------------------------------o-----------------------------------o
CapsLock & `::                                                       ;|
GetKeyState, CapsLockState, CapsLock, T                              ;|
if CapsLockState = D                                                 ;|
    SetCapsLockState, AlwaysOff                                      ;|
else                                                                 ;|
    SetCapsLockState, AlwaysOn                                       ;|
KeyWait, ``                                                          ;|
return                                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                         CapsLock Escaper:                          ;|
;----------------------------------o----------------------------------o
;                        CapsLock  |  {ESC}                          ;|
;----------------------------------o----------------------------------o
CapsLock::
Send, {ESC}                                                ;|
SoundBeep, 500, 200
;SetCapsLockState, Off
DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,, UInt, 1))
ime=0
return



uStr(str)
{
    charList:=StrSplit(str)
	SetFormat, integer, hex
    for key,val in charList
    out.="{U+ " . ord(val) . "}"
	return out
}

;在系统中已安装的输入法信息在注册表 HKEY_USERS/.DEFAULT/Keyboard Layout/Preload 。里面只有输入法的键盘布局名称，如 E0040840 左E004说明该输入法的标识（智能ABC）右0804 说明该输入法为 中文输入法。其输入法的具体名称可到注册表HKEY_LOCAL_MACHINE/SYSTEM/CurrentControlSet/Control /Keyboard Layouts/ 输入法的键盘布局名称 。Layout Text键值为该输入法的名称。
;注意：可能显示的已安装的输入法比任务栏的输入法列表少，你可以到HKEY_LOCAL_MACHINE/SYSTEM /CurrentControlSet/Control/Keyboard Layouts/ 找到所有在系统中已注册的输入法。
;E0200804 微软必应输入法
;E0210804 中文(简体) - 搜狗拼音输入法
;00000804 Chinese (Simplified) - US Keyboard

/*
f1::
SoundBeep, 1000, 100
SetCapsLockState, Off
DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,"E0210804", UInt, 1))

return 
f2::
SoundBeep, 500, 200
SetCapsLockState, Off
DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,, UInt, 1))
return
*/

$^;::Sendinput  % uStr(";")
ime=0
CapsLock & '::
{
if ime=0
{
SoundBeep, 1000, 100
;SetCapsLockState, Off
;DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,"E0210804", UInt, 1))
DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,"E0200804", UInt, 1))
  ime=1
}
else
{
SoundBeep, 500, 200
;SetCapsLockState, Off
DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,, UInt, 1))

  ime=0
}
}
return 
;---------------------------------------------------------------------o



;=====================================================================o
;                    CapsLock Direction Navigator                    ;|
;-----------------------------------o---------------------------------o
;                      CapsLock + h |  Left                          ;|
;                      CapsLock + j |  Down                          ;|
;                      CapsLock + k |  Up                            ;|
;                      CapsLock + l |  Right                         ;|
;                      Ctrl, Alt Compatible                          ;|
;-----------------------------------o---------------------------------o
CapsLock & h::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {Left}                                                 ;|
    else                                                             ;|
        Send, +{Left}                                                ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{Left}                                                ;|
    else                                                             ;|
        Send, +^{Left}                                               ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & j::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {Down}                                                 ;|
    else                                                             ;|
        Send, +{Down}                                                ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{Down}                                                ;|
    else                                                             ;|
        Send, +^{Down}                                               ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & k::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {Up}                                                   ;|
    else                                                             ;|
        Send, +{Up}                                                  ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{Up}                                                  ;|
    else                                                             ;|
        Send, +^{Up}                                                 ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & l::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {Right}                                                ;|
    else                                                             ;|
        Send, +{Right}                                               ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{Right}                                               ;|
    else                                                             ;|
        Send, +^{Right}                                              ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                     CapsLock Home/End Navigator                    ;|
;-----------------------------------o---------------------------------o
;                      CapsLock + i |  Home                          ;|
;                      CapsLock + o |  End                           ;|
;                      Ctrl, Alt Compatible                          ;|
;-----------------------------------o---------------------------------o
CapsLock & i::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {Home}                                                 ;|
    else                                                             ;|
        Send, +{Home}                                                ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{Home}                                                ;|
    else                                                             ;|
        Send, +^{Home}                                               ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & o::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {End}                                                  ;|
    else                                                             ;|
        Send, +{End}                                                 ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{End}                                                 ;|
    else                                                             ;|
        Send, +^{End}                                                ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                      CapsLock Page Navigator                       ;|
;-----------------------------------o---------------------------------o
;                      CapsLock + u |  PageUp                        ;|
;                      CapsLock + p |  PageDown                      ;|
;                      Ctrl, Alt Compatible                          ;|
;-----------------------------------o---------------------------------o
CapsLock & u::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {PgUp}                                                 ;|
    else                                                             ;|
        Send, +{PgUp}                                                ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{PgUp}                                                ;|
    else                                                             ;|
        Send, +^{PgUp}                                               ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & p::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {PgDn}                                                 ;|
    else                                                             ;|
        Send, +{PgDn}                                                ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{PgDn}                                                ;|
    else                                                             ;|
        Send, +^{PgDn}                                               ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                     CapsLock Mouse Controller                      ;|
;-----------------------------------o---------------------------------o
;                   CapsLock + Up   |  Mouse Up                      ;|
;                   CapsLock + Down |  Mouse Down                    ;|
;                   CapsLock + Left |  Mouse Left                    ;|
;                  CapsLock + Right |  Mouse Right                   ;|
;    CapsLock + Enter(Push Release) |  Mouse Left Push(Release)      ;|
;-----------------------------------o---------------------------------o
CapsLock & Up::    MouseMove, 0, -10, 0, R                           ;|
CapsLock & Down::  MouseMove, 0, 10, 0, R                            ;|
CapsLock & Left::  MouseMove, -10, 0, 0, R                           ;|
CapsLock & Right:: MouseMove, 10, 0, 0, R                            ;|
;-----------------------------------o                                ;|
CapsLock & Enter::                                                   ;|
SendEvent {Blind}{LButton down}                                      ;|
KeyWait Enter                                                        ;|
SendEvent {Blind}{LButton up}                                        ;|
return                                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                           CapsLock Deletor                         ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + n  |  Ctrl + Delete (Delete a Word) ;|
;                     CapsLock + m  |  Delete                        ;|
;                     CapsLock + ,  |  BackSpace                     ;|
;                     CapsLock + .  |  Ctrl + BackSpace              ;|
;-----------------------------------o---------------------------------o
CapsLock & ,:: Send, {Del}                                           ;|
CapsLock & .:: Send, ^{Del}                                          ;|
CapsLock & m:: Send, {BS}                                            ;|
CapsLock & n:: Send, ^{BS}                                           ;|
;---------------------------------------------------------------------o



;=====================================================================o
;                            CapsLock Editor                         ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + z  |  Ctrl + z (Cancel)             ;|
;                     CapsLock + x  |  Ctrl + x (Cut)                ;|
;                     CapsLock + c  |  Ctrl + c (Copy)               ;|
;                     CapsLock + v  |  Ctrl + z (Paste)              ;|
;                     CapsLock + a  |  Ctrl + a (Select All)         ;|
;                     CapsLock + y  |  Ctrl + z (Yeild)              ;|
;                     CapsLock + w  |  Ctrl + Right(Move as [vim: w]);|
;                     CapsLock + b  |  Ctrl + Left (Move as [vim: b]);|
;-----------------------------------o---------------------------------o
/*
CapsLock & z:: Send, ^z                                              ;|
CapsLock & x:: Send, ^x                                              ;|
CapsLock & c:: Send, ^c                                              ;|
CapsLock & v:: Send, ^v                                              ;|
CapsLock & a:: Send, ^a                                              ;|
CapsLock & y:: Send, ^y
*/                                              ;|
CapsLock & w:: Send, ^{Right}                                        ;|
CapsLock & b:: Send, ^{Left}                                         ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                       CapsLock Media Controller                    ;|
;-----------------------------------o---------------------------------o
;                    CapsLock + F1  |  Volume_Mute                   ;|
;                    CapsLock + F2  |  Volume_Down                   ;|
;                    CapsLock + F3  |  Volume_Up                     ;|
;                    CapsLock + F3  |  Media_Play_Pause              ;|
;                    CapsLock + F5  |  Media_Prev                    ;|
;                    CapsLock + F6  |  Media_Next                    ;|
;                    CapsLock + F7  |  Media_Stop                    ;|
;-----------------------------------o---------------------------------o
/*
CapsLock & F1:: Send, {Volume_Mute}                                  ;|
CapsLock & F2:: Send, {Volume_Down}                                  ;|
CapsLock & F3:: Send, {Volume_Up}                                    ;|
CapsLock & F4:: Send, {Media_Play_Pause}                             ;|
CapsLock & F5:: Send, {Media_Prev}                                   ;|
CapsLock & F6:: Send, {Media_Next}                                   ;|
CapsLock & F7:: Send, {Media_Stop}                                   ;|
*/
;---------------------------------------------------------------------o


;=====================================================================o
;                -----       CapsLock Window Controller                    ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + s  |  Ctrl + Tab (Swith Tag)        ;|
;                     CapsLock + q  |  Ctrl + W   (Close Tag)        ;|
;   (Disabled)  Alt + CapsLock + s  |  AltTab     (Swith Windows)    ;|
;               Alt + CapsLock + q  |  Alt + F4   (Close Windows)    ;|
;                     CapsLock + g  |  AppsKey    (Menu Key)         ;|
;-----------------------------------o---------------------------------o
;CapsLock & g::Send, ^{Tab}                                           ;|
;-----------------------------------o                                ;|
;CapsLock & q::                                                       ;|
;if GetKeyState("alt") = 0                                            ;|
;{                                                                    ;|
;    Send, ^w                                                         ;|
;}                                                                    ;|
;else {                                                               ;|
;    Send, !{F4}                                                      ;|
;    return                                                           ;|
;}                                                                    ;|
;return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & s:: Send, {AppsKey}                                       ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                     -----    CapsLock Self Defined Area                  ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + d  |  Alt + d(Dictionary)           ;|
;                     CapsLock + f  |  Alt + f(Search via Everything);|
;                     CapsLock + e  |  Open Search Engine            ;|
;                     CapsLock + r  |  Open Shell                    ;|
;                     CapsLock + t  |  Open Text Editor              ;|
;-----------------------------------o---------------------------------o

;CapsLock & d:: Send, !d                                              ;|
;CapsLock & f:: Send, !f                                              ;|
;CapsLock & e:: Run http://cn.bing.com/                               ;|
;CapsLock & r:: Run Powershell                                        ;|
;CapsLock & t:: Run C:\Program Files (x86)\Notepad++\notepad++.exe    ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                       ----- CapsLock Char Mapping                       ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + ;  |  Enter (Cancel)                ;|
;                     CapsLock + '  |  =                             ;|
;                     CapsLock + [  |  Back         (Visual Studio)  ;|
;                     CapsLock + ]  |  Goto Define  (Visual Studio)  ;|
;                     CapsLock + /  |  Comment      (Visual Studio)  ;|
;                     CapsLock + \  |  Uncomment    (Visual Studio)  ;|
;                     CapsLock + 1  |  Build and Run(Visual Studio)  ;|
;                     CapsLock + 2  |  Debuging     (Visual Studio)  ;|
;                     CapsLock + 3  |  Step Over    (Visual Studio)  ;|
;                     CapsLock + 4  |  Step In      (Visual Studio)  ;|
;                     CapsLock + 5  |  Stop Debuging(Visual Studio)  ;|
;                     CapsLock + 6  |  Shift + 6     ^               ;|
;                     CapsLock + 7  |  Shift + 7     &               ;|
;                     CapsLock + 8  |  Shift + 8     *               ;|
;                     CapsLock + 9  |  Shift + 9     (               ;|
;                     CapsLock + 0  |  Shift + 0     )               ;|
;-----------------------------------o---------------------------------o
;CapsLock & `;:: Send, {Enter}                                        ;|
;CapsLock & ':: Send, =                                               ;|
;CapsLock & [:: Send, ^-                                              ;|
;CapsLock & ]:: Send, {F12}                                           ;|
;-----------------------------------o                                ;|
;CapsLock & /::                                                       ;|
;Send, ^e                                                             ;|
;Send, c                                                              ;|
;return                                                               ;|
;;-----------------------------------o                                ;|
;CapsLock & \::                                                       ;|
;Send, ^e                                                             ;|
;Send, u                                                              ;|
;return                                                               ;|
;;-----------------------------------o                                ;|
;CapsLock & 1:: Send,^{F5}                                            ;|
;CapsLock & 2:: Send,{F5}                                             ;|
;CapsLock & 3:: Send,{F10}                                            ;|
;CapsLock & 4:: Send,{F11}                                            ;|
;CapsLock & 5:: Send,+{F5}                                            ;|
;;-----------------------------------o                                ;|
;CapsLock & 6:: Send,+6                                               ;|
;CapsLock & 7:: Send,+7                                               ;|
;CapsLock & 8:: Send,+8                                               ;|
;CapsLock & 9:: Send,+9                                               ;|
;CapsLock & 0:: Send,+0                                               ;|
;;---------------------------------------------------------------------o


;---------------------------------------------------------------------o

;;CapsLock+e映射滚轮向下，CapsLock+y映射滚轮向上
CapsLock & e::
Send {WheelDown}
return
CapsLock & y::
CapsLock & f::
Send {WheelUp}
return
/*
CapsLock & '::
send, ^{space}
return
*/
/*
;Delete Backspace的映射 
!h::Send {Backspace} 
!l::Send {Delete} 
!u:: Send, ^{BS} 
!o:: Send, ^{Del}
*/
;;

LAlt & Capslock::ShiftAltTab



;;---------------------------------------------------------------------o

;补，，，2016年3月30日10:07:04
;url编码解码 
uriEncode(str) { 
f = %A_FormatInteger% 
SetFormat, Integer, Hex 
If RegExMatch(str, "^\w+:/{0,2}", pr) 
StringTrimLeft, str, str, StrLen(pr) 
StringReplace, str, str, `%, `%25, All 
Loop 
If RegExMatch(str, "i)[^\w\.~%]", char) 
StringReplace, str, str, %char%, % "%" . Asc(char), All 
Else Break 
SetFormat, Integer, %f% 
Return, pr . str 
} 
uriDecode(str) { 
Loop 
If RegExMatch(str, "i)(?<=%)[\da-f]{1,2}", hex) 
StringReplace, str, str, `%%hex%, % Chr("0x" . hex), All 
Else Break 
Return, str 
} 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;快速命令;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
:://g:: 
Run http://www.google.com 
return 
:://b:: 
Run http://www.baidu.com 
return 

;:://s:: 
;Run C:\Program Files\Everything\Everything.exe 
;return 

:://qq:: 
Run C:\Program Files\Tencent\QQ\Bin\QQ.exe 
return 

:://pcmd:: 
Run cmd 
return 

;:://n:: 
;Run notepad 
;return 

;:://d:: 
;Run C:\Program Files\http://dict.cn\DianDian.exe 
;return 

:://pe:: 
Run explorer 
return 


::dakf:: 
Run "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"
return 

::dakv:: 
Run "C:\Program Files (x86)\Vim\vim74\gvim.exe"
return 

::wdid::
send 421123199111155655
return
/*
;打开任务管理器 
:://t:: 
if WinExist Windows 任务管理器 
WinActivate 
else 
Run taskmgr.exe 
return 
*/

;一些经常输入的字符串 
::wdqm:: 
Send 1367297309@qq.com 
return 

::wdqq:: 
Send 1367297309
return 

;打开系统属性 
:://psys:: 
Run control sysdm.cpl 
return 

;;打开autohotkey 配置文件 
;:://ahk:: 
;Run D:\GreenSoft\AutoHotKey 中文版\AutoHotKey.ini 
;return 
;;;;;;;;;;快速打开程序(快捷键);;;;;;;;;;;;;;;;;;;;;;;;; 

;用google搜索 
!g:: 
Send ^c 
Run http://www.google.com/search?q=%clipboard% 
return 
;用百度搜索 
!b:: 
Send ^c 
Run http://www.baidu.com/s?wd=%clipboard% 
return 
;淘宝搜索
!t:: 
Send ^c 
Run http://s.taobao.com/search?q=%clipboard% 
return 



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;通用键的映射;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;对windows下的一些常用键进行映射,与苹果下的一些习惯一样(苹果下的快捷键有些非常合理:) 

;!f::Send ^f ;查找 
!q:: !F4 ;退出 
;!w::Send ^w ;关闭网页窗口 
;!r::Send #r 
;!s::Send ^s ;保存 
;!n::Send ^n ;新建 
;!z::Send ^z 
;选择文字 
!h::Send ^+{Left} 
!l::Send ^+{Right} 
return 

!y:: Send +{Home} ;选择当前位置到行首的文字
!p:: Send +{End} ;选择当前位置到行末的文字 

;选择一行 
!a:: 
Send {Home} 
Send +{End} 
return 

;鼠标的左右键实现任务切换,对thinkpad trackpoint 特别有用 
~LButton & RButton::AltTab 
~LButton & MButton::MsgBox,hello,昭哥

;<短时间双击alt键切换capslock键> 
;~ 设置一个时钟，比如400 毫秒， 
;~ 设置一个计数器，Alt_presses，按击次数，每次响应时钟把计数器清0复位 
#Persistent 
$Alt:: 
if Alt_presses > 0 ; SetTimer 已经启动，所以我们记录按键。 
{ 
Alt_presses += 1 
return 
} 
;否则，这是新一系列按键的首次按键。将计数设为 1 并启动定时器： 
Alt_presses = 1 
SetTimer, KeyAlt, 300 ;在 300 毫秒内等待更多的按键。 
return 

KeyAlt: 
SetTimer, KeyAlt, off 
if Alt_presses = 1 ;该键已按过一次。 
{ 
Gosub singleClick 
} 
else if Alt_presses = 2 ;该键已按过两次。 
{ 
Gosub doubleClick 
} 

;不论上面哪个动作被触发，将计数复位以备下一系列的按键： 
Alt_presses = 0 
return 

singleClick: 
send {alt} 
return 

doubleClick: 
if GetKeyState("Capslock", "T") 
SetCapsLockState,off 
else 
SetCapsLockState,on 
return 

;</短时间双击alt键切换capslock键> 

;copy cut paste 的快捷键 
;!c::Send ^c 
;!x::Send ^x 
;!v::Send ^v 

;上页翻页键映射 
;!h::Send {PgUp} 
;!;::Send {PgDn} 
;HOME END键映射 
;!u:: Send {Home} ; 
;!o:: Send {End} ; 
;Alt + jkli 实现对方向键的映射,写代码的时候灰常有用 
;!j:: Send {left} 
;!l:: Send {right} 
;!i:: Send {up} 
;!k:: Send {down} 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;通用键的映射;(结束);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;实用功能;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
/*
;win键 + PrintScreen键关闭屏幕 
#PrintScreen:: 
KeyWait PrintScreen 
KeyWait LWin ;释放左Win键才激活下面的命令 
SendMessage,0x112,0xF170,2,,Program Manager ;关闭显示器。0x112:WM_SYSCOMMAND，0xF170:SC_MONITORPOWER。2：关闭，-1：开启显示器 
Return 
*/
/* 
;双击鼠标右键在窗口最大化与正常状态之间切换 
WinStatus:=0 
RButton:: 
KeyWait, RButton ;松开鼠标右键后才继续执行下面的代码 
keyWait, RButton, D T0.15 ;在 100 毫秒内等待再次按下鼠标右键，可以设置一个自己觉得适合的等待时间。 

If ErrorLevel 
Click, Right 

Else 
{ 
if WinStatus=0 
{ 
WinMaximize , A 
WinStatus:=1 
} 
else 
{ 
WinRestore ,A 
WinStatus:=0 
} 
} 
Return 
!m:: 
if WinStatus=0 
{ 
WinMaximize , A 
WinStatus:=1 
} 
else 
{ 
WinRestore ,A 
WinStatus:=0 
} 
return 

;命令行cmd里可以ctrl v 
#IfWinActive ahk_class ConsoleWindowClass 
^v:: 
MouseClick, Right, %A_CaretX%, %A_CaretY%,,0 
send p 
return 

*/ 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;实用功能(结束);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<Chrome>;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
/*
#IfWinActive ahk_class Chrome_WidgetWin_0 
!,::Send ^+{Tab} 
!.::Send ^{Tab} 
!1::Send ^+{Tab} 
!2::Send ^{Tab} 
!n::Send ^t 
!/::Send ^w 
!z::Send ^+t 
!-::Send ^- 
!=::Send ^= 
*/

;选择当前位置到页尾的文字,适用于浏览器 
F2:: 
Send ^+{End} 
;Send ^c 
return 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<资源管理器>;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
/*
#IfWinActive ahk_class CabinetWClass 
!f:: 
Run C:\Program Files\Everything\Everything.exe 
return 
*/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<Notepad>;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

/*
#IfWinActive ahk_class Notepad 
;!u::Send ^{Home} 
;!o::Send ^{End} 
return 
*/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<Eclipse>;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
/*
#IfWinActive,Eclipse 
!.::Send ^{F8} 
return 
*/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<VisualStudio 2008>;;;;;;;;;;;;;;;;;;;;;;; 
/*
#IfWinActive ahk_class wndclass_desked_gsk 
!/::Send ^{Tab} 
!.::Send ^+{Tab} 
!m::Send !+{Enter} 
return 
*/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<ADB>;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<Onenote>;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
/*
#IfWinActive ahk_class OfficeTooltip 
!u::Send ^{Home} 
!o::Send ^{End} 
return
*/

