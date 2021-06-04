<?php

$timesTable = 7;
$stopAt = 300;
$timesOutput = [];

for($i = 1; $i <= $stopAt; ++$i)
{
    $output = "{$timesTable} * {$i} = ";

    array_push($timesOutput,$output.compute($timesTable,$i));
}

echo implode(', ',$timesOutput); // to remove last comma

// or rtrim($string, ",") could be used to remove the last comma for a string

function compute($timesTable,$timesBy)
{
    $count = 0;

    for($i = 0; $i < $timesBy; $i++)
    {
        $count += $timesTable;
    }

    return $count;
}