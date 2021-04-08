/* 
	@author: Md. Mahfuzur Rahman
	https://mahfuznow.com
*/

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
}
