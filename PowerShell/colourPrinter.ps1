$max = [System.ConsoleColor].GetFields().Count -1

for ($i = 0; $i -lt $max; $i++)
{	
	$fore = [System.ConsoleColor]($i)
	$back = [System.ConsoleColor](($max - 1) - $i)
	Write-Host -BackgroundColor $back -ForegroundColor $fore "$fore text on $back background"
}
