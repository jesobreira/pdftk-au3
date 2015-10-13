#include 'class\pdftk.au3'

; This is already working
Local $oObject = New_PDFTK()
; $oObject.SetDebugMode() ; just if you want
$oObject.Cmd("test.pdf background letterhead.pdf output done.pdf")

; This is not working yet
#cs
$oObject.Input("page.pdf")

$oObject.Output("result.pdf")

$oObject.Multistamp("background.pdf")
#ce