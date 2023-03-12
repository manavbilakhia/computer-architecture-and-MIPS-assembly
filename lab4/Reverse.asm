addi $s7 $s0 3

lw	$s1, 0($s0)
lw	$s2, 1($s0)
lw	$s3, 2($s0)
lw	$s4, 3($s0)
lw	$s5, 1($s7)
lw	$s6, 2($s7)

sw  $s1, 2($s7)
sw  $s2, 1($s7)
sw  $s3, 3($s0)
sw  $s4, 2($s0)
sw  $s5, 1($s0)
sw  $s6, 3($s0)