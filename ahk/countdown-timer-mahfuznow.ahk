/* 
	@author: Md. Mahfuzur Rahman
	https://mahfuznow.com
*/
#SingleInstance, force ; Disallow to running multiple intances of same script
Menu, Tray, Tip, % "Coundown Timer - mahfuznow (AHK)"
Menu, Tray, Icon, % "shell32.dll", 266 ;Set System tray icon (clock)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Defining color schemes according to the windows app Theme ;;;;;;;;;;;;;;;;;;;;;;;;
RegRead, CurrentTheme, % "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize", % "AppsUseLightTheme"
if(CurrentTheme) {
  ;Light Theme
  background_color := "E8E8E8"
  color1 := "0683B0"
  color2 := "974EAC"
  color3 := "A6A6A6"
}
else {
  ;Dark Theme
  background_color := "212121"
  color1 := "0ABCFD"
  color2 := "DB71F9"
  color3 := "000000"
}

;;;;;;;;;;;;;;; Creating Gui and adding components ;;;;;;;;;;;;;;;;;;;;;;;;;;

Gui +LastFound -Caption +AlwaysOnTop +ToolWindow ;  LastFound -> required for transparent background; Caption-> window title ; ToolWindow -> avoids a taskbar button and an alt-tab menu item.
Gui, Color, %background_color%
Gui, Font, s25 , Calibri ; Set font
Gui, Add, Text, vTextMin x30 c%color1%, 00
Gui, Font, s23
Gui, Add, Text, vTextSec x+10 c%color2%, 00

Gui, Add, Progress, vMyProgressMin x30 w200 h10 c%color1% Background%color3%
Gui, Add, Progress, vMyProgressSec w200 h10 c%color2% Background%color3%
; Gui, Add, Progress, vMyProgressSmooth x+10 y-0 w10 h100 -Smooth Vertical , % "75" ;We can't use custom color if we use smooth


; WinSet, TransColor, %background_color_dark% 150 ; Transparrent background & transparent window


;;;;;;;;;;;;;;; Finding Bottom-Right position of screen where we will place our Gui's Top-left corner ;;;;;;;;;;;;
Gui, Show, x10000 y10000 ;Showing the gui to find its Width and Height (the position of the gui is setted large value so that it shows outside the screen)
WinGetPos X, Y, Width, Height, A
Gui Cancel
xPos := A_ScreenWidth - Width -30 ; This will put the Gui to the right
yPos := A_ScreenHeight - Height - 30 ; This will put the Gui above the taskbar, you just need to adjust the "30" value as you want
Gui, Show, x%xPos% y%yPos% NoActivate ;will show the gui but won't activate it
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; TODO: User defined Time ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
myMinutes := 20 ; 20 min pomodoro
mySeconds :=myMinutes*60


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Countdown starts ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SetTimer, Update, 1000 ; A timer which will trigger "Update" in every 1000 milisecond/ 1 second

count := mySeconds
Update:
  min := Floor(count/60)
  min:=SubStr("00" . min,-1) ;Leading zero for values less than 10
  sec := Mod(count,60) 
  sec:=SubStr("00" . sec,-1) ;Leading zero for values less than 10
  GuiControl,,TextMin, %min%
  GuiControl,,TextSec, %sec%
  GuiControl,, MyProgressMin, % (min/myMinutes*100)
  GuiControl,, MyProgressSec, % (sec/60*100)

  if (--count < 0) {
    SetTimer, Update, off
    ;Hide elements
    GuiControl, Hide, TextMin
    GuiControl, Hide, TextSec
    GuiControl, Hide, MyProgressMin
    GuiControl, Hide, MyProgressSec
    ; Show copleted message
    Gui, Add, Text, vTextEnd x0 y50 w260 +Center c%color2%, Coundown Ends
    Gui, show, NoActivate
  }
return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;---------------------------------------------------------------------------------------------------------;
;;;;;;;;;;;;;; Hide/Unhide & Exit ;;;;;;;;;;;;;
Esc:: 
  {
    if(isDoublePressed("Esc")) {
      MsgBox, 4,Coundown Timer, Do you really want to Terminate this script?
      ifMsgBox, Yes
      exitapp
    }
    else {
      toggle := !toggle
      If toggle
        Gui, hide
      else
        Gui, show, NoActivate
    }
    Return
  }

;;;;;;;;;;;;;; Reload/Reset ;;;;;;;;;;;; (if we use F5 then it will be called automaticaly when Theme changes from mahfuznow script)
F5::
  MsgBox, 4,Coundown Timer, Do you really want to Reset The Countdown?
  ifMsgBox, Yes
  Reload
Return

isDoublePressed(key) {
  KeyWait, %key%	, U		
  KeyWait, %key%	, D T.1
return !ErrorLevel
}


