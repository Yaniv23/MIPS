x"20", x"08", x"00", x"00",  -- addi $t0, $zero, 0      ; $t0 = 0         ; counter
x"20", x"09", x"00", x"05",  -- addi $t1, $zero, 5      ; $t1 = 5         ; limit
x"01", x"09", x"50", x"2A",  -- slt  $t2, $t0, $t1      ; $t2 = ($t0 < $t1) ? 1 : 0
x"11", x"40", x"00", x"01",  -- beq  $t2, $zero, end    ; if $t2 == 0, exit loop
x"21", x"08", x"00", x"01",  -- addi $t0, $t0, 1        ; $t0 = $t0 + 1
x"08", x"00", x"00", x"02",  -- j    loop               ;repeat loop
x"AE", x"28", x"00", x"00",  -- sw   $t0, 0($s1)        ; store final value of $t0 at address in $s1
others => x"00"
