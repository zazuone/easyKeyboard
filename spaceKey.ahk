#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

/******************************************
如此一来，其他地方的Space组合键就会失效

*******************************************/
Space::
send {Space}
return
Space & a::
send 1
Return
Space & s::
send 2
Return
Space & d::
send 3
Return
Space & f::
send 4
Return
Space & g::
send 5
Return
Space & h::
send 6
Return
Space & j::
send 7
Return
Space & k::
send 8
Return
Space & l::
send 9
Return
Space & `;::
send 0
Return


/******************************************
解决其他地方的space组合键失效问题
******************************************/
;处理find and run robot
^Space::
	send ^{Space}
return

;处理MapAppLuancher
+Space::
	send +{Space}
return

