function StressCPUCores {
param ($numberOfCores)

#You can un-comment next line to get all available number of cores on the machine. Use with caution: CPU usage on where script is running will reach 100%.  
#$numOfCores = Get-WmiObject –class Win32_processor | Select -ExpandProperty NumberOfCores

Write-Host "Number of cores to target: " $numberOfCores
foreach ($counter in 1..$numberOfCores){
    Start-Job -ScriptBlock{
    $result = 1
        foreach ($number in 1..2147483647){
            $result = $result * $number
        }# end foreach
    }# end Start-Job
}# end foreach

}

StressCPUCores $args[0]
