# Opens a list of installed true type fonts in an IE window

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

$objFonts = New-Object System.Drawing.Text.InstalledFontCollection
$colFonts = $objFonts.Families

$objIE = New-Object -com "InternetExplorer.Application"
$objIE.Navigate("about:blank")
$objIE.ToolBar = 0
$objIE.StatusBar = 0
$objIE.Visible = $True

$objDoc = $objIE.Document.DocumentElement.LastChild 

foreach ($objFont in $colFonts)
    {
        $strHTML = $strHTML + "<font size='6' face='" + $objFont.Name + "'>" + $objFont.Name + "</font><br>"
    }

$objDoc.InnerHTML = $strHTML