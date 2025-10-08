#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



; =====================
; Simple autofill
; =====================
:*:bb;::Brendan Beck
return

:*:b@::brendan.beck62@gmail.com
return

:*:c@::chickenisgood62@gmail.com
return

:*:]d::
FormatTime, CurrentDateTime,, M/d/yyyy
SendInput %CurrentDateTime%
return

:*:linkedin;::https://www.linkedin.com/in/brendan-beck/
return

:*:github;::https://github.com/brendanbeck62
return


; =====================
; Launch Websites
; =====================
; twitter
; ^+t::Run "www.twitter.com" ; use ctrl+Shift+t
; return


; =====================
; Open directories
; =====================
; downloads
#+d::Run "C:\Users\chick\Downloads" ; win+shift+d
return

; vibe-otd
#+v::Run "C:\Users\chick\Pictures\vibeOTD" ; win+shift+v
return
