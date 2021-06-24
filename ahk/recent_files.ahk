if A_OSVersion in WIN_98,WIN_ME,WIN_XP 
{
  EnvGet, Path, UserProfile
  fd = %Path%\Recent
}
else
  fd=%A_AppData%\Microsoft\Windows\Recent
Menu, RM, UseErrorLevel
Menu, RM, DeleteAll
Menu, RM, Delete
FileList =
Loop, %fd%\*.*, 0, 0
    FileList = %FileList%%A_LoopFileTimeModified%`t%A_LoopFileFullPath%`n
Sort, FileList, R
Loop, parse, FileList, `n
{
   if (A_index=16)
      break
   if A_LoopField =
      continue
   StringSplit, FileItem, A_LoopField, %A_Tab%
   OutTarget= %FileItem2%
   Splitpath, OutTarget,name,,Ext
   FileGetShortcut, %OutTarget%, FileTo
   FileGetAttrib, Attributes, %FileTo%
   SplitPath, FileTo,name,,Ext
   If InStr(Attributes, "D" )
   {
      IconFile:="C:\Windows\system32\imageres.dll"
      icc:=4
   }
   else
   {
      IconFile:=AssocQueryApp(Ext)
      icc:=2
   }
   Menu, RM, Add, %name%, LabelR
   Menu, RM, Icon, %name%, %IconFile%, %icc%, 16
   if errorlevel
      Menu, RM, Icon, %name%, %IconFile%, 1, 16
   if errorlevel
      Menu, RM, Icon, %name%, C:\Windows\system32\imageres.dll, 12, 16
}
Menu, RM, show
Return

LabelR:
run, %fd%\%A_ThisMenuItem%.lnk,,useerrorlevel
return

AssocQueryApp(ext) {
	RegRead, type, HKCU, Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.%Ext%, Application
	If !ErrorLevel {
		RegRead, act, HKCU, Software\Classes\Applications\%type%\shell
		If ErrorLevel
			act = open
		RegRead, cmd, HKCU, Software\Classes\Applications\%type%\shell\%act%\command
    }
	Else {
		RegRead, type, HKCR, .%Ext%
		RegRead, act , HKCR, %type%\shell
		If ErrorLevel
			act = open
        RegRead, cmd , HKCR, %type%\shell\%act%\command
        EXEPosition := InStr(cmd,".exe",false,0,1)
        exepath := Trim(SubStr(cmd,1,EXEPosition+3),"""")
    }
    Return, exepath
}