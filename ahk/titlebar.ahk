; This script will hide and unhide titlebar of any window (Active window). This only works with the programs which uses windows provided toogleTitlebar
; like notepad, file explorer etc. On the other hand Chrome,Vscode have their own titlebar. In that case we need to use window crop instead.
; In that case we also need to use this script in order to remove the outer border of that window

#SingleInstance, Force

; Press CTRL+t to toggle
^t::
  toogleTitlebar := !toogleTitlebar
  if(toogleTitlebar)
    WinSet, Style, -0xC40000, A ;-0xC40000 removes titlebar and the outer border. -0xC00000 only removes the title bar
  Else
    WinSet, Style, +0xC40000, A ;add titlebar
Return