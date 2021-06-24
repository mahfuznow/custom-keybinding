#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

Gui, Color, 212121
Gui, -Caption +AlwaysOnTop 0x800000
Gui, Font, s10, Verdana

Gui, Add, Progress, x10 y10 w300 h20 vIndex c00C6FF Background000000
Gui, Add, Text, x10 y10 w300 h20 +0x200 cFFFFFF +Center +BackgroundTrans vText , 1 of 100
Gui, Add, Text, x10 y+2 w300 h20 +0x200 c00C6FF +Center +BackgroundTrans vFile 

Gui, Show ;,h55 , Progress.Bar.GUI

Loop, %WinDir%\system32\*.*
{
	IfGreater, A_Index,100, Break
	GuiControl,, Index, % A_Index
	GuiControl,, File, % A_LoopFileName
	GuiControl,, Text, % A_Index " of 100"
	Sleep 100
}
Return

GuiEscape:
   ExitApp