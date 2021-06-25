#SingleInstance, Force

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
