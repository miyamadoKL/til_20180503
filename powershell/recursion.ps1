$a = @(1, @(2, @(3, @(4, @(5)))))
$b = @(1, 2, 3, 4, 5)

function f($n) {
    $ret = @()
    foreach($x in $n) {
        if (!($x -is [array])) {
            $ret = @($x)
        } else {
            $ret += f($x)
        }
    }
    return $ret
}

$c = f($a)

$d = ""

#Check the number of elements is equal.
Compare-Object $b $c -PassThru | ForEach-Object{$d += $_}

#Check the order of elements si equal.
for ($i=0;$i -lt [Math]::Min($b.length, $c.Length);$i++) {
    if ($b[$i] -ne $c[$i]) {
        $d += $b[$i]
    }
}

if ($d.Length -eq 0){    
    Write-Host "OK!"
} else {
    Write-Host "NG"
}
