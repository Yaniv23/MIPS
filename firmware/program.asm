    addi $t0, $zero, 0      ; $t0 = 0         ; counter
    addi $t1, $zero, 5      ; $t1 = 5         ; limit
loop:
    slt  $t2, $t0, $t1      ; $t2 = ($t0 < $t1) ? 1 : 0
    beq  $t2, $zero, end    ; if $t2 == 0, exit loop
    addi $t0, $t0, 1        ; $t0 = $t0 + 1
    j    loop               ;repeat loop
end:
    sw   $t0, 0($s1)        ; store final value of $t0 at address in $s1