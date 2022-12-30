-- ******************************************
-- Guillermo Aznar
--	DSP with FPGA: HW 5
-- ******************************************
-- IIR filter
-- ******************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY iir5sfix is
	PORT (clk		:		IN STD_LOGIC;
	      reset    :		IN STD_LOGIC;
			x_in		:		IN INTEGER RANGE 7 DOWNTO 0;
			t_out		:		OUT INTEGER RANGE 13 DOWNTO 0;
			y_out		:		OUT INTEGER RANGE 13 DOWNTO 0);
END;

ARCHITECTURE fpga of iir5sfix IS

	SIGNAL t, x, y : INTEGER RANGE 26 TO 0 := 0;
	SIGNAL m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10 : INTEGER RANGE 26 TO 0 := 0; -- A registers
	SIGNAL n0, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10 : INTEGER RANGE 26 TO 0 := 0; -- B registers
	SIGNAL a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10 : INTEGER RANGE 26 TO 0 := 0;
	SIGNAL b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10 : INTEGER RANGE 26 TO 0 := 0;
	
BEGIN

	a0 <= t;
	a1 <= -t/4096 -t/1024 +t/256 -t/64 + 4*t;
	a2 <= -t/4096 +t/1024 -t/32 +t/8 +8*t;
	a3 <= -t/4096 +t/128 -t/32 +t/2 +2*t +8*t;
	a4 <= -t/2048 +t/512 -t/64 -t/16 +t/2 +2*t +8*t;
	a5 <= t/4096 -t/512 -t/128 -t/32 +t/8 +2*t +8*t;
	a6 <= t/4096 -t/1024 -t/128 -t/32 -t/8 +t +8*t;
	a7 <= -t/1024 -t/16 +t;
	a8 <= -t/512 -t/128 -t/32 +t/4;
	a9 <= t/1024 -t/256 +t/32;
	a10 <= -t/4096 +t/512;
	
	b0 <= 0*t;
	b1 <= 2*t;
	b2 <= t +8*t;
	b3 <= 8*t +16*t;
	b4 <= t +2*t +8*t +32*t;
	b5 <= t +2*t -26*t +64*t;
	b6 <= t +2*t +8*t +32*t;
	b7 <= 8*t +16*t;
	b8 <= t +8*t;
	b9 <= 2*t;
	b10 <= 0*t;
	
	P1: PROCESS (reset, clk)
	BEGIN
	m9 <= a10;
	m8 <= m9 + a9;
	m7 <= m8 + a8;
	m6 <= m7 + a7;
	m5 <= m6 + a6;
	m4 <= m5 + a5;
	m3 <= m4 + a4;
	m2 <= m3 + a3;
	m1 <= m2 + a2;
	m0 <= m1 + a1;
	t <= m0 + a0;
	n9 <= b10;
	n8 <= n9 + b9;
	n7 <= n8 + b8;
	n6 <= n7 + b7;
	n5 <= n6 + b6;
	n4 <= n5 + b5;
	n3 <= n4 + b4;
	n2 <= n3 + b3;
	n1 <= n2 + b2;
	n0 <= n1 + b1;
	
		
	END PROCESS P1;
	
	y_out <= y;
	t_out <= x;
END fpga;
