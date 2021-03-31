
/* 
| Shortcut                         | Output                           |
| -------------------------------- | -------------------------------- |
|CAPSLOCK ON { i, j, k, l }        | { Up, Left, Down, Right }        |
|CAPSLOCK ON { u, o }              | { Home, End }                    |
|CAPSLOCK ON { y, h }              | { PageUp, PageDown }             |
*/

#if GetKeyState("CapsLock", "T")
{

	i::Send {Up}
	return
	
	k::Send {Down}
	return
	
	j::Send {Left}
	return
	
	l::Send {Right}
	return
	
	u::Send {Home}
	return
	
	o::Send {End}
	return
	
	y:: send, {PgUp}
	return
	
	h:: send, {PgDn}
	return

}