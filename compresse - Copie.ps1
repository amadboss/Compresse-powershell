#REPLACE <PATH> BY YOUR FILES PATH

#SAVING LAST 7 DAYS OLD FILE ON ANOTHER PLACE
foreach ($line in Get-ChildItem –Path "<PATH>" -Recurse | Where {($_.LastWriteTime -gt (Get-Date).AddDays(-8))}){
$tmp = $line.name
write-host $tmp
if (!(test-path -path "<PATH>\$tmp")){
Copy-Item "<PATH>\$line" -Destination "<destination path>"}
else{write-host "$tmp already saved"}
}





#Creating group depending of last modified date
$groups = Get-ChildItem "<PATH>" | 
    Where-Object { ($_.LastWriteTime -lt (Get-Date).AddDays(-8)) -and ($_.psIsContainer -eq $false) } | 
    group {"{0:MMMM} {0:yyyy}" -f $_.lastwritetime}

#Compresse and delete after
ForEach ($group in $groups) {
    ForEach($file in $group.Group){
        $tmp = $file.Name
        $tmp2 = ($group.Name + ".zip")
        #write-host "archivage theorique de $tmp dans $tmp2"
        #write-host ""
        #write-host "suppresion theorique de $tmp"
        Compress-Archive -path <PATH>\$tmp -update -DestinationPath <PATH>\$tmp2
        remove-item <PATH>\$tmp
    }
}