#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;crop facebook messanger
^1::
  toggleCrop:=!toggleCrop
  if toggleCrop {
    WinMaximize, A
    WinGetPos, X, Y, W, H, A
    width := W/3
    height := H-100 ;100 is the height of chrome tab and addressbar
    xPos := width*2 ;top left position of our desired crop window
    ;WinSet, Style, -0xC00000, A ;removes windows title bar
    WinSet, Region, %xPos%-100 W%width% H%height% R20-20, A ;crop window
  }
  else {
    WinSet, Region,, A
    ;WinSet, Style, +0xC00000, A ;add the windows title bar
  }
return

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
    ;WinSet, Style, -0xC00000, A ;removes title bar	
    WinSet, Region, 0-100 W%width% H%height% R20-20, A ;crop window ; best for chrome

    WinRestore, A ;this is required because winMove won't work in fullscreen
    WinMove, A, , xPos, yPos , %width%, %height%
    
  }
  else {
    WinSet, Region,, A
    WinMaximize, A
    ;WinSet, Style, +0xC00000, A ;add the windows title bar
  }
return
