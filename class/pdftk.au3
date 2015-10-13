#cs ----------------------------------------------------------------------------
 PDF-TK Class
 Author:    Jefrey <jefrey[at]jefrey.ml>

 Powered by:
   pdf-tk <https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/>

 Using:
   AutoItObject by ProgAndy ET AL <https://www.autoitscript.com/forum/topic/110379-autoitobject-udf/>
   CreateFilesEmbebbed by JScript <https://www.autoitscript.com/forum/topic/132564-createfilesembeddedau3-like-fileinstall/>

 Based on:
   https://www.pdflabs.com/docs/pdftk-man-page/#dest-output-filename
   https://www.pdflabs.com/docs/pdftk-cli-examples/
#ce ----------------------------------------------------------------------------

#include-once

; Include embebbed EXE files (for a lib, it's better than FileInstall())
#include "pdftk.exe.au3"
#include "libiconv2.dll.au3"

; Include and start AutoItObject
#include "AutoItObject.au3"

_AutoItObject_StartUp()

; Set error handler
Global $oError = ObjEvent("AutoIt.Error", "_ErrFunc")

#Region variables
Global $__PTK_Loaded = False

Global $__PTK_EXE_File = @TempDir & "\pdftk.exe"
Global $__PTK_DLL_File = @TempDir & "\libiconv2.dll"

Global $oInnput = ObjCreate("Scripting.Dictionary")
#EndRegion

Func _PDFTK_StartUp()
	If FileExists($__PTK_EXE_File) Then
		$attrib = FileGetAttrib($__PTK_EXE_File)
		If StringInStr($attrib, "D") Then
			DirRemove($__PTK_EXE_File, 1)
		Else
			FileDelete($__PTK_EXE_File)
		EndIf
	EndIf
	If FileExists($__PTK_DLL_File) Then
		$attrib = FileGetAttrib($__PTK_DLL_File)
		If StringInStr($attrib, "D") Then
			DirRemove($__PTK_DLL_File, 1)
		Else
			FileDelete($__PTK_DLL_File)
		EndIf
	EndIf

   _pdftk(True, @TempDir)
   _libiconv2(True, @TempDir)
   Global $__PTK_Loaded = True
   OnAutoItExitRegister("_PDFTK_Shutdown")
EndFunc

Func _PDFTK_Shutdown()
   If $__PTK_Loaded Then
	  FileDelete($__PTK_EXE_File)
	  FileDelete($__PTK_DLL_File)
	  $__PTK_Loaded = False
   EndIf
EndFunc

Func New_PdfTK()
   If Not $__PTK_Loaded Then
	  _PDFTK_StartUp()
   EndIf

   Local $oClassObject = _AutoItObject_Class()
   $oClassObject.Create()

   $oClassObject.AddProperty("DebugMode", $ELSCOPE_PUBLIC, False)
   $oClassObject.AddProperty("WorkingDir", $ELSCOPE_PUBLIC, @ScriptDir)

   ; Additional arguments
   $oClassObject.AddProperty("Custom", $ELSCOPE_PUBLIC, Null)

   $oClassObject.AddMethod("SetDebugMode", "__PDFTK_DebugMode")
   $oClassObject.AddMethod("Replace", "__PDFTK_Replace")

   $oClassObject.AddMethod("Cmd", "__PDFTK_Cmd")
   $oClassObject.AddMethod("DoIt", "__PDFTK__DoIt")

   Return $oClassObject.Object
EndFunc

Func __PDFTK_Cmd($oSelf, $sCmd)
   ShellExecuteWait($__PTK_EXE_File, $sCmd, $oSelf.WorkingDir, 'open', ($oSelf.DebugMode ? @SW_SHOW : @SW_HIDE) )
EndFunc

Func __PDFTK_DebugMode($oSelf, $bMode = Default)
   If $bMode = Default Then
	  If $oSelf.DebugMode Then
		 $oSelf.DebugMode = False
	  Else
		 $oSelf.DebugMode = True
	  EndIf
   Else
	  $oSelf.DebugMode = $bMode
   EndIf
   Return True
EndFunc

Func __PDFTK_DoIt($oSelf)
	; later, when this wrapper supports native calls - and not command line queries only
EndFunc

Func _ErrFunc()
    ConsoleWrite("! COM Error !  Number: 0x" & Hex($oError.number, 8) & "   ScriptLine: " & $oError.scriptline & " - " & $oError.windescription & @CRLF)
    Return
EndFunc   ;==>_ErrFunc
