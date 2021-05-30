/* 
	@author: Md. Mahfuzur Rahman
	https://mahfuznow.com
*/
#SingleInstance, force ; Disallow to running multiple intances of same script

isDoublePressed(key) {
  KeyWait, %key%	, U		
  KeyWait, %key%	, D T.1
  return !ErrorLevel
}

SetCapsLockState, AlwaysOff
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
