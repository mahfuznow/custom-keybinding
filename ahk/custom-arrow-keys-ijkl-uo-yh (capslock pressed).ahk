/* 
| Shortcut                         | Output                           |
| -------------------------------- | -------------------------------- |
| CAPSLOCK + { i, j, k, l }        | { Up, Left, Down, Right }        |
| CAPSLOCK + { u, o }              | { Home, End }                    |
| CAPSLOCK + { y, h }              | { PageUp, PageDown }             |
*/


SetCapsLockState, AlwaysOff


CapsLock & i::
    Send {Up}
return

CapsLock & k::
    Send {Down}
return

CapsLock & j::
    Send {Left}
return

CapsLock & l::
    Send {Right}
return

CapsLock & u::
    Send {Home}
return

CapsLock & o::
    Send {End}
return

CapsLock & y:: send, {PgUp}
CapsLock & h:: send, {PgDn}

return