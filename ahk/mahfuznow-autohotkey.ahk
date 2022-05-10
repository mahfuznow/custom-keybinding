/* 
	@author: Md. Mahfuzur Rahman
	https://mahfuznow.com
*/
#SingleInstance, force ; Disallow to running multiple intances of same script

appName := "Shortcut key - mahfuznow (AHK)"

Menu, Tray, Tip, %appName%
Menu, Tray, Icon, % "shell32.dll", 174 ;Set System tray icon

SetNumLockState, AlwaysOn ; Always on Num lock
SetCapsLockState, Off ; Turn this off if already On
SetCapsLockState, AlwaysOff ; This is reuquired because we are forcefully using Caps lock button as a modifier key.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; script control shortcuts ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
^F5::
  MsgBox, 4,%appName%,Do you really want to Reload this script?
  ifMsgBox, Yes
  reload
return
^F6::
  MsgBox, 4,%appName%,Do you really want to Pause this script?
  ifMsgBox, Yes
  pause
return
^F7::
  MsgBox, 4,%appName%,Do you really want to Terminate this script?
  ifMsgBox, Yes
exitapp
return
^F8::
  Run, "D:\Program Files\Microsoft VS Code\Code.exe" "%A_ScriptFullPath%"
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;crop facebook messanger ; medium
^1::
  toggleCrop:=!toggleCrop
  if toggleCrop {
    WinMaximize, A
    WinGetPos, X, Y, W, H, A
    width := W/3
    height := H-100 ;100 is the height of chrome tab and addressbar
    xPos := width*2 ;top left position of our desired crop window
    WinSet, Style, -0xC40000, A ;-0xC40000 removes titlebar and the outer border.
    WinSet, Region, %xPos%-100 W%width% H%height% R20-20, A ;crop window
  }
  else {
    WinSet, Region,, A
    WinSet, Style, +0xC40000, A ;-0xC40000 adds titlebar and the outer border.
  }
return

;crop facebook messanger ; small
^2::
  toggleCrop:=!toggleCrop
  if toggleCrop {
    WinMaximize, A
    WinGetPos, X, Y, W, H, A
    width := W/3
    height := H/3
    xPos := width*2
    yPos := height*2-100 ;100 is the height of chrome tab and addressbar
    height += 100

    WinSet, Style, -0xC40000, A ;-0xC40000 removes titlebar and the outer border.
    WinSet, Region, 10-100 W%width% H%height% R20-20, A ;crop window ; here 10 

    WinRestore, A ;this is required because winMove won't work in fullscreen
    WinMove, A, , xPos, yPos , %width%, %height%
  }
  else {
    WinSet, Region,, A
    WinMaximize, A
    WinSet, Style, +0xC40000, A ;-0xC40000 adds titlebar and the outer border.
  }
return


#if GetKeyState("CapsLock", "P")
{

4::
  WinGetPos,,, Width, Height, A
  WinMove, A,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
return

!c::
  ;Run, %USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Chrome (mahfuz.cse.just)\Md. Mahfuzur (mahfuz.cse.just) - Chrome.lnk
  Run, "C:\Program Files\Google\Chrome\Application\chrome.exe" --app=http://facebook.com
Return

=::
  InputBox, password, Enter Password, (your input will be hidden), hide 
Return

i::send {Up}
return

k::send {Down}
return

j::send {Left}
return

l::send {Right}
return

u::send {Home}
return

o::send {End}
return

y:: send {PgUp}
return

h:: send {PgDn}
return

;CHANGE ACTIVE WINDOW
Space::
  {
    if(isDoublePressed("Space"))
      send !{Tab}
    else
      send #{Tab}
    return
  }
  ;MINIMIZE ACTIVE WINDOW
8::
  {
    if(isDoublePressed("8"))
      WinMinimize A
    else
      send 8
    return
  }

  ;RESIZING ACTIVE WINDOW
9::
  {
    if(isDoublePressed("9"))
    {
      WinGet MX, MinMax, A
      if MX
        WinRestore A
      else 
        WinMaximize A 
    }
    else
      send 9
    return
  }

  ;CLOSE ACTIVE WINDOW
0::
  {
    if(isDoublePressed("0"))
      send !{F4}
    else
      send 0
    return
  }

  ;SELECT OR ENTER
  n::send {Enter}
return

;MOUSE CLICK LEFT
b::send {Click}
return

;MOUSE CLICK RIGHT
m::send {Click Right}
return

;SNAP WINDOW TO LEFT
,::send #{Left}
return

;SNAP WINDOW TO RIGHT
.::send #{Right}
return

;TOGGLE DESKTOP
d::send #d
return

;CHANGE FOCUS IN CHROME
g:: send {F6}
return

;1:: WinSet, Region, 10-00 W400 H400 R20-20, ahk_class Notepad
;return
;2:: WinSet, Region,, ahk_class Notepad

1::
  toggleTitleBar:=!toggleTitleBar
  if toggleTitleBar {
    WinGetPos, X, Y, W, H, A
    width := W-20
    height := H-10
    WinSet, Style, -0xC00000, A ;removes title bar
    ;WinSet, Region, 0-0 W%W% H%H% R20-20, A ;crop window ;best for vscode
    ;WinSet, Region, 10-0 W%width% H%height% R20-20, A ;crop window ; best for chrome
    WinSet, Region, 1000-100 W500 H%H% R20-20, A ;crop window ; best for chrome
  }
  else {
    WinSet, Region,, A
    WinSet, Style, +0xC00000, A ;add the title bar
  }
return

3::
  WinGetTitle, currentWindow, A
  IfWinExist %currentWindow%
    WinSet, Style, -0xC40000,
  WinMove, , , 0, 0, A_ScreenWidth, A_ScreenHeight
  DllCall("SetMenu", "Ptr", WinExist(), "Ptr", 0)
return

`::
  toggleTitleBar:=!toggleTitleBar
  if toggleTitleBar {
    WinMaximize, A
    WinGetPos, X, Y, W, H, A
    width := W/3
    height := H-100
    xPos := width*2

    WinMove, A, , xPos, 50 , %width%, %height%
    WinSet, Style, -0xC00000, A ;removes title bar	
    WinSet, Region, 50-100 W%width% H%height% R20-20, A ;crop window ; best for chrome
    WinRestore, A ;this is required because winMove won't work in fullscreen

  }
  else {
    WinSet, Region,, A
    WinMaximize, A
  }
return

;crop facebook messanger
\::
  toggleTitleBar:=!toggleTitleBar
  if toggleTitleBar {
    WinMaximize, A
    WinGetPos, X, Y, W, H, A
    width := W/3
    height := H-100 ;100 is the height of chrome tab and addressbar
    xPos := width*2
    WinSet, Style, -0xC00000, A ;removes title bar
    WinSet, Region, %xPos%-100 W%width% H%height% R20-20, A ;crop window
  }
  else {
    WinSet, Region,, A
    WinSet, Style, +0xC00000, A ;add the title bar
  }
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Windows teminal --- CP Editor ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
t::
  IfWinActive, ahk_class Qt5152QWindowIcon ; If CP editor window is activated
    IfWinExist ahk_class CASCADIA_HOSTING_WINDOW_CLASS ; If windows terminal already running
    WinActivate
  Else {
    WinGetTitle, Title, A ; get the Title of the CP-Editor Window = path_of_the_opened_file
    LastSlashPos := InStr(Title,"/",0,0) ; get position of last occurrence of "/" from the Title
    directory := SubStr(Title,1,LastSlashPos-1) ; get substring from start to last slash
    directory := """" directory """" ; """" means escapped "
    Run %USERPROFILE%\AppData\Local\Microsoft\WindowsApps\wt.exe -d %directory% ; Opening Windows terminal 
  }
  Else
    Run %USERPROFILE%\AppData\Local\Microsoft\WindowsApps\wt.exe -d L:\
Return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Command promt ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
c::
  IfWinExist, ahk_class ConsoleWindowClass
    WinActivate
  Else
    Run, cmd
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Transparent window ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
v::
  toggleTranparent:=!toggleTranparent
  if toggleTranparent
    WinSet, Transparent, 200 , A ;transparency
  else
    WinSet, Transparent, OFF , A
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Show Menu for recent files and folders ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
e::
  showRecentFilesAndFolders()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Toogle dark mode light mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

q::
  ; read current theme
  RegRead, CurrentTheme, % "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize", % "AppsUseLightTheme"
  ; toggle between themes
  RegWrite, REG_DWORD, % "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize", % "AppsUseLightTheme", % 1 - CurrentTheme
  ;if the application is a browser relaod the page
  IfWinActive, ahk_class Chrome_WidgetWin_1
    send {f5}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; whindowAlwaysOnTop ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
w::
  whindowAlwaysOnTop() ;N.B: whindow , not window
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Add or remove program - Control Panel ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
p::
  Run, appwiz.cpl,, Max
Return
}

;#Hotstring R ; Parse hotstring in raw mode (To allow symbols in the hotstring)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Hot Strings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#if GetKeyState("Shift", "P")
{
  ::mn::www.mahfuznow.com

::cpp::
  val =
  (
  #include<iostream>
  using namespace std;
  #define Int long long
  int main()
  {

  }
  )
  old_clipboard = %Clipboard% ; Saving what is in the Clipboard currently
  Clipboard = %val% ; Copy the snipet into Clipboard
  Send, ^v ; Paste it
  Sleep, 50 ; Some delay is important to finishing the paste operation
  Clipboard = %old_clipboard% ; Restore the old Clipboard
Return

::java::
  val =
  (
  import java.util.*;
  class Main {
    public static void main(String[] args)
    {
      Scanner sc = new Scanner(System.in);
      int n;
      n = sc.nextInt();
      System.out.println(n);
    }
  }
  )
  old_clipboard = %Clipboard% ; Saving what is in the Clipboard currently
  Clipboard = %val% ; Copy the snipet into Clipboard
  Send, ^v ; Paste it
  Sleep, 50 ; Some delay is important to finishing the paste operation
  Clipboard = %old_clipboard% ; Restore the old Clipboard
Return

}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

isDoublePressed(key) {
  KeyWait, %key%	, U		
  KeyWait, %key%	, D T.1
return !ErrorLevel
}

whindowAlwaysOnTop() {
  Winset,AlwaysOnTop,,A
  WinGetTitle, Name, A
  If (SubStr(Name, 1, 1) = "+")
    Name:=Name := SubStr(Name, 3)
  else
    Name:="+ " . Name ;chr(134)
  WinSetTitle, A, , %Name%
}
;ALTERNATIVE: WinSet, AlwaysOnTop, Toggle, Calculator

showRecentFilesAndFolders() {
  if A_OSVersion in WIN_98,WIN_ME,WIN_XP 
  {
    EnvGet, Path, UserProfile
    fd = %Path%\Recent
  }
  else
    fd=%A_AppData%\Microsoft\Windows\Recent
  Menu, RM, UseErrorLevel
  Menu, RM, DeleteAll
  Menu, RM, Delete
  FileList =
  Loop, %fd%\*.*, 0, 0
    FileList = %FileList%%A_LoopFileTimeModified%`t%A_LoopFileFullPath%`n
  Sort, FileList, R
  Loop, parse, FileList, `n
  {
    if (A_index=16)
      break
    if A_LoopField =
      continue
    StringSplit, FileItem, A_LoopField, %A_Tab%
    OutTarget= %FileItem2%
    Splitpath, OutTarget,name,,Ext
    FileGetShortcut, %OutTarget%, FileTo
    FileGetAttrib, Attributes, %FileTo%
    SplitPath, FileTo,name,,Ext
    If InStr(Attributes, "D" )
    {
      IconFile:="C:\Windows\system32\imageres.dll"
      icc:=4
    }
    else
    {
      IconFile:=AssocQueryApp(Ext)
      icc:=2
    }
    Menu, RM, Add, %name%, LabelR
    Menu, RM, Icon, %name%, %IconFile%, %icc%, 16
    if errorlevel
      Menu, RM, Icon, %name%, %IconFile%, 1, 16
    if errorlevel
      Menu, RM, Icon, %name%, C:\Windows\system32\imageres.dll, 12, 16
  }
  Menu, RM, show
Return

LabelR:
  run, %fd%\%A_ThisMenuItem%.lnk,,useerrorlevel
return
}

AssocQueryApp(ext) {
  RegRead, type, HKCU, Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.%Ext%, Application
  If !ErrorLevel {
    RegRead, act, HKCU, Software\Classes\Applications\%type%\shell
    If ErrorLevel
      act = open
    RegRead, cmd, HKCU, Software\Classes\Applications\%type%\shell\%act%\command
  }
  Else {
    RegRead, type, HKCR, .%Ext%
    RegRead, act , HKCR, %type%\shell
    If ErrorLevel
      act = open
    RegRead, cmd , HKCR, %type%\shell\%act%\command
    EXEPosition := InStr(cmd,".exe",false,0,1)
    exepath := Trim(SubStr(cmd,1,EXEPosition+3),"""")
  }
Return, exepath
}
