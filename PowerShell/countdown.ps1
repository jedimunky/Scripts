param 
( 
$CountdownYear="2019" 
) 
 
Function Draw-Number($digit,$Column) 
{ 
 
$Number=New-object 'object[,]' 11,8 
 
$Number[0,0]="******* " 
$Number[0,1]="*     * " 
$Number[0,2]="*     * " 
$Number[0,3]="*     * " 
$Number[0,4]="*     * " 
$Number[0,5]="*     * " 
$Number[0,6]="******* " 
$Number[0,7]="        " 
 
$Number[1,0]="      * " 
$Number[1,1]="      * " 
$Number[1,2]="      * " 
$Number[1,3]="      * " 
$Number[1,4]="      * " 
$Number[1,5]="      * " 
$Number[1,6]="      * " 
$Number[1,7]="        " 
 
$Number[2,0]="******* " 
$Number[2,1]="      * " 
$Number[2,2]="      * " 
$Number[2,3]="******* " 
$Number[2,4]="*       " 
$Number[2,5]="*       " 
$Number[2,6]="******* " 
$Number[2,7]="        " 
 
$Number[3,0]="******* " 
$Number[3,1]="      * " 
$Number[3,2]="      * " 
$Number[3,3]="******* " 
$Number[3,4]="      * " 
$Number[3,5]="      * " 
$Number[3,6]="******* " 
$Number[3,7]="        " 
 
$Number[4,0]="*     * " 
$Number[4,1]="*     * " 
$Number[4,2]="*     * " 
$Number[4,3]="******* " 
$Number[4,4]="      * " 
$Number[4,5]="      * " 
$Number[4,6]="      * " 
$Number[4,7]="        " 
 
$Number[5,0]="******* " 
$Number[5,1]="*       " 
$Number[5,2]="*       " 
$Number[5,3]="******* " 
$Number[5,4]="      * " 
$Number[5,5]="      * " 
$Number[5,6]="******* " 
$Number[5,7]="        " 
 
$Number[6,0]="******* " 
$Number[6,1]="*       " 
$Number[6,2]="*       " 
$Number[6,3]="******* " 
$Number[6,4]="*     * " 
$Number[6,5]="*     * " 
$Number[6,6]="******* " 
$Number[6,7]="        " 
 
$Number[7,0]="******* " 
$Number[7,1]="      * " 
$Number[7,2]="      * " 
$Number[7,3]="      * " 
$Number[7,4]="      * " 
$Number[7,5]="      * " 
$Number[7,6]="      * " 
$Number[7,7]="        " 
 
$Number[8,0]="******* " 
$Number[8,1]="*     * " 
$Number[8,2]="*     * " 
$Number[8,3]="******* " 
$Number[8,4]="*     * " 
$Number[8,5]="*     * " 
$Number[8,6]="******* " 
$Number[8,7]="        " 
 
$Number[9,0]="******* " 
$Number[9,1]="*     * " 
$Number[9,2]="*     * " 
$Number[9,3]="******* " 
$Number[9,4]="      * " 
$Number[9,5]="      * " 
$Number[9,6]="******* " 
$Number[9,7]="        " 
 
$Number[10,0]="        " 
$Number[10,1]="   **   " 
$Number[10,2]="   **   " 
$Number[10,3]="        " 
$Number[10,4]="   **   " 
$Number[10,5]="   **`  " 
$Number[10,6]="        " 
$Number[10,7]="        " 
 
$Adjust=($column*10)+8 
 
$Remember=$host.ui.RawUI.CursorPosition 
$Base=$Remember 
 
$base.X=$base.X+$adjust 
$Y=$base.Y 
 
    for($a=0;$a -le 7;$a++) 
    { 
    $host.ui.RawUI.CursorPosition=$base 
    write-host -foregroundcolor Yellow -object $number[$digit,$a] -NoNewline 
    $y++ 
    $Base.Y=$Y 
    } 
 
$host.ui.RawUI.CursorPosition=$Remember 
 
} 
 
[datetime]$Countdown="01/01/$CountdownYear 00:00" 
 
CLEAR-HOST 
$size=$host.ui.RawUI.WindowSize 
$size.Height=20 
$size.width=100 
 
$host.ui.rawui.WindowSize=$size 
 
$starthere=$host.ui.RawUI.CursorPosition 
do 
{ 
$data=($Countdown-(GET-DATE)) 
$Days=$data.days 
 
$host.ui.RawUI.CursorPosition=$starthere 
$host.ui.RawUI.WindowTitle=(GET-DATE).tostring() 
 
WRITE-HOST -ForegroundColor Cyan -Object "`n`n                        It is now $Days Day(s) until New Years Eve $CountdownYear and ...`n`n" 
WRITE-HOST -ForegroundColor Green "              HOURS                        MINUTES                       SECONDS`n`n" 
 
Draw-Number ($data.hours.tostring().padleft(2,"0").substring(0,1)) 0 
Draw-Number ($data.hours.tostring().padleft(2,"0").substring(1,1)) 1 
Draw-Number 10 2 
Draw-Number ($data.minutes.tostring().padleft(2,"0").substring(0,1)) 3 
Draw-Number ($data.minutes.tostring().padleft(2,"0").substring(1,1)) 4 
Draw-Number 10 5 
Draw-Number ($data.seconds.tostring().padleft(2,"0").substring(0,1)) 6 
Draw-Number ($data.seconds.tostring().padleft(2,"0").substring(1,1)) 7 
 
start-sleep -Seconds .75 
} 
until((GET-DATE) -gt $Countdown) 
      
CLEAR-HOST 
 
do  
{ 
$Here=$host.ui.RawUI.CursorPosition 
$here.X=30 
$here.Y=10 
$host.ui.RawUI.CursorPosition=$Here 
WRITE-HOST -foregroundColor (GET-RANDOM ("Black","Blue","Cyan","Gray","Green","Magenta","Red","White","Yellow")) -OBJECT "H A P P Y   N E W   Y E A R   $countdownyear" -nonewline 
start-sleep .75 
} until ($FALSE) 