/* 
| Shortcut                         | Output                           |
| -------------------------------- | -------------------------------- |
|CAPSLOCK ON { i, j, k, l }        | { Up, Left, Down, Right }        |
|CAPSLOCK ON { u, o }              | { Home, End }                    |
|CAPSLOCK ON { y, h }              | { PageUp, PageDown }             |
*/

#if GetKeyState("CapsLock", "T")
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

} 

#if GetKeyState("NumLock", "T")
{
	;MINIMIZE ACTIVE WINDOW
	Numpad7::
    	KeyWait, Numpad7			
   	 KeyWait, Numpad7, D T0.1		
   	 if ErrorLevel						; single press		
        send 7
   	 Else								; double press
        WinMinimize A
	return

	;;RESIZING ACTIVE WINDOW
	Numpad8::
    	KeyWait, Numpad8			
   	 KeyWait, Numpad8, D T0.1		
   	 if ErrorLevel						;single press
        send 8
   	 Else								; double press
		WinGet MX, MinMax, A
		If MX
			WinRestore A
		Else WinMaximize A    
	return

	;CLOSE ACTIVE WINDOW
	Numpad9::
    	KeyWait, Numpad9			
   	 KeyWait, Numpad9, D T0.1		
   	 if ErrorLevel 					
        send 9
   	 Else
        send !{F4}
	return

	;SHIFT + ALT + TAB
	Numpad4:: 
   		send !+{tab} 
	return

	;TOOGLE TASK VIEW
	Numpad5:: 
   		send #{tab} 
	return	
	
	;ALT + TAB
	Numpad6:: 
   		send !{tab} 
	return

	;SNAP WINDOW TO LEFT
	Numpad1::
		send #{Left}
	return
	
	;
	Numpad2::
		send 2
	return

	;SNAP WINDOW TO RIGHT
	Numpad3::
		send #{Right}
	return

	;TOGGLE DESKTOP
	Numpad0::
		send #d
	return

}
