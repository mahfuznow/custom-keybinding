/* 
	@author: Md. Mahfuzur Rahman
	https://mahfuznow.com
*/
#SingleInstance, force ; Disallow to running multiple intances of same script

; Gui +LastFound -Caption +Border +hwndgHwnd
Gui +LastFound -Caption +hwndgHwnd
Gui, Color, 000000
WinSet, TransColor, 000000
Gui, Font, s64, Calibri
Gui, Add, Text, x0 y200 w500 Center cWhite, Hi Mahfuz!
Gui, Show, w500 h500 Center
EnableBlur(gHwnd)


EnableBlur(gHwnd)
{
  ; WindowCompositionAttribute
  WCA_ACCENT_POLICY := 19

  ; AccentState
  ACCENT_DISABLED := 0,
  ACCENT_ENABLE_GRADIENT := 1,
  ACCENT_ENABLE_TRANSPARENTGRADIENT := 2
  ACCENT_ENABLE_BLURBEHIND := 3
  ACCENT_INVALID_STATE := 4

  accentStructSize := VarSetCapacity(AccentPolicy, 4*4, 0)
  NumPut(ACCENT_ENABLE_BLURBEHIND, AccentPolicy, 0, "UInt")

  padding := A_PtrSize == 8 ? 4 : 0
  VarSetCapacity(WindowCompositionAttributeData, 4 + padding + A_PtrSize + 4 + padding)
  NumPut(WCA_ACCENT_POLICY, WindowCompositionAttributeData, 0, "UInt")
  NumPut(&AccentPolicy, WindowCompositionAttributeData, 4 + padding, "Ptr")
  NumPut(accentStructSize, WindowCompositionAttributeData, 4 + padding + A_PtrSize, "UInt")

  DllCall("SetWindowCompositionAttribute", "Ptr", gHwnd, "Ptr", &WindowCompositionAttributeData)
}
