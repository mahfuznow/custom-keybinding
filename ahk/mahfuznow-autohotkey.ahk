/* 
	@author: Md. Mahfuzur Rahman
	https://mahfuznow.com
*/
#SingleInstance, force ; Disallow to running multiple intances of same script
Menu, Tray, Tip, % "Shortcut key - mahfuznow (AHK)"
Menu, Tray, Icon, % "shell32.dll", 174 ;Set System tray icon

SetNumLockState, AlwaysOn ; Always on Num lock

SetCapsLockState, Off ; Turn this off if already On
SetCapsLockState, AlwaysOff ; This is reuquired because we are forcefully using Caps lock button as a modifier key.
#if GetKeyState("CapsLock", "P")
{

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
      Run wt -d %directory% ; Opening Windows terminal 
    }
    Else
      Run wt -d L:\
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
    whindowAlwaysOnTop()
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
