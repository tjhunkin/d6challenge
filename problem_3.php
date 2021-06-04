<?php

function fibonacci($n)
{
    if ($n < 2) return $n;

    return fibonacci($n - 1) + fibonacci($n - 2);
}

function output($n)
{
    for($i = 0; $i < $n; $i++)
    {
        echo fibonacci($i) . PHP_EOL;
    }
}

output(9);