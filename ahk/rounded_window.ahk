; This script will crop any window in a rounded shape

#SingleInstance, Force

; Press CTRL+r to toggle
^r::
  toogleRounded := !toogleRounded
  if(toogleRounded){
    WinGetPos, X, Y, W, H, A
    width := W-20
    height := H-10
    WinSet, Style, -0xC40000, A ;-0xC40000 removes titlebar and the outer border. -0xC00000 only removes the title bar

    If (WinActive("ahk_exe chrome.exe") or WinActive("ahk_exe msedge.exe")) {
      WinSet, Region, 10-0 W%width% H%height% R20-20, A ;crop window ; best for chrome and edge browser
    }
    else {
      WinSet, Region, 0-0 W%W% H%H% R20-20, A ;crop window ;best for vscode and other programs
    }
  }
  else {
    WinSet, Region,, A
    WinSet, Style, +0xC40000, A ;add titlebar
  }
Return