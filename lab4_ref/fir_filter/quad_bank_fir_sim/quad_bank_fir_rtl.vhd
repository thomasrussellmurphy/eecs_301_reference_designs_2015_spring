-- ------------------------------------------------------------------------- 
-- Altera DSP Builder Advanced Flow Tools Release Version 13.1
-- Quartus II development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2013 Altera Corporation.  All rights reserved.
-- Your use of  Altera  Corporation's design tools,  logic functions and other
-- software and tools,  and its AMPP  partner logic functions, and  any output
-- files  any of the  foregoing  device programming or simulation files),  and
-- any associated  documentation or information are expressly subject  to  the
-- terms and conditions  of the Altera Program License Subscription Agreement,
-- Altera  MegaCore  Function  License  Agreement, or other applicable license
-- agreement,  including,  without limitation,  that your use  is for the sole
-- purpose of  programming  logic  devices  manufactured by Altera and sold by
-- Altera or its authorized  distributors.  Please  refer  to  the  applicable
-- agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from quad_bank_fir_rtl
-- VHDL created on Fri Feb 20 23:46:22 2015


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity quad_bank_fir_rtl is
    port (
        xIn_v : in std_logic_vector(0 downto 0);
        xIn_c : in std_logic_vector(7 downto 0);
        xIn_0 : in std_logic_vector(11 downto 0);
        bankIn_0 : in std_logic_vector(1 downto 0);
        xOut_v : out std_logic_vector(0 downto 0);
        xOut_c : out std_logic_vector(7 downto 0);
        xOut_0 : out std_logic_vector(34 downto 0);
        clk : in std_logic;
        areset : in std_logic
    );
end quad_bank_fir_rtl;

architecture normal of quad_bank_fir_rtl is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";

    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_bankIn_0_15_q : STD_LOGIC_VECTOR (1 downto 0);
    signal d_xIn_0_15_q : STD_LOGIC_VECTOR (11 downto 0);
    signal d_in0_m0_wi0_wo0_assign_sel_q_15_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_count : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_run_pre_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_out : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_enable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_ctrl : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_memread_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_memread_q_14_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_compute_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_15_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_17_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_18_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_ra0_count0_q : STD_LOGIC_VECTOR (8 downto 0);
    signal u0_m0_wo0_wi0_ra0_count0_i : UNSIGNED (7 downto 0);
    signal u0_m0_wo0_wi0_ra0_count0_sc : SIGNED (8 downto 0);
    signal u0_m0_wo0_wi0_ra0_count1_q : STD_LOGIC_VECTOR (8 downto 0);
    signal u0_m0_wo0_wi0_ra0_count1_i : UNSIGNED (7 downto 0);
    signal u0_m0_wo0_wi0_ra0_add_0_0_a : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_ra0_add_0_0_b : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_ra0_add_0_0_o : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_ra0_add_0_0_q : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_ra1_count0_q : STD_LOGIC_VECTOR (8 downto 0);
    signal u0_m0_wo0_wi0_ra1_count0_i : UNSIGNED (7 downto 0);
    signal u0_m0_wo0_wi0_ra1_count0_sc : SIGNED (8 downto 0);
    signal u0_m0_wo0_wi0_ra1_count1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_ra1_count1_i : UNSIGNED (7 downto 0);
    signal u0_m0_wo0_wi0_ra1_count1_eq : std_logic;
    signal u0_m0_wo0_wi0_ra1_add_0_0_a : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_ra1_add_0_0_b : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_ra1_add_0_0_o : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_ra1_add_0_0_q : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_we1_seq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_we1_seq_eq : std_logic;
    signal u0_m0_wo0_wi0_wa0_q : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_wa0_i : UNSIGNED (7 downto 0);
    signal u0_m0_wo0_wi0_wa1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_wa1_i : UNSIGNED (7 downto 0);
    signal u0_m0_wo0_wi0_delayr0_reset0 : std_logic;
    signal u0_m0_wo0_wi0_delayr0_ia : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_delayr0_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_delayr0_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_delayr0_iq : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_delayr0_q : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_delayr1_reset0 : std_logic;
    signal u0_m0_wo0_wi0_delayr1_ia : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_delayr1_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_delayr1_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_delayr1_iq : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_delayr1_q : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_bank_delayr0_reset0 : std_logic;
    signal u0_m0_wo0_bank_delayr0_ia : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_bank_delayr0_aa : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_bank_delayr0_ab : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_bank_delayr0_iq : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_bank_delayr0_q : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_ca0_q : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_ca0_i : UNSIGNED (7 downto 0);
    signal u0_m0_wo0_ca0_eq : std_logic;
    signal u0_m0_wo0_cm0_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_symSuppress_0_seq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_symSuppress_0_seq_eq : std_logic;
    signal u0_m0_wo0_sym_add0_a : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_sym_add0_b : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_sym_add0_i : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_sym_add0_o : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_sym_add0_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_b0 : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_s1 : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_0_q : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_aseq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_aseq_eq : std_logic;
    signal u0_m0_wo0_accum_a : STD_LOGIC_VECTOR (34 downto 0);
    signal u0_m0_wo0_accum_b : STD_LOGIC_VECTOR (34 downto 0);
    signal u0_m0_wo0_accum_i : STD_LOGIC_VECTOR (34 downto 0);
    signal u0_m0_wo0_accum_o : STD_LOGIC_VECTOR (34 downto 0);
    signal u0_m0_wo0_accum_q : STD_LOGIC_VECTOR (34 downto 0);
    signal u0_m0_wo0_oseq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_oseq_eq : std_logic;
    signal u0_m0_wo0_oseq_gated_reg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_ra1_count1_lut_lutmem_reset0 : std_logic;
    signal u0_m0_wo0_wi0_ra1_count1_lut_lutmem_ia : STD_LOGIC_VECTOR (8 downto 0);
    signal u0_m0_wo0_wi0_ra1_count1_lut_lutmem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_ra1_count1_lut_lutmem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_ra1_count1_lut_lutmem_iq : STD_LOGIC_VECTOR (8 downto 0);
    signal u0_m0_wo0_wi0_ra1_count1_lut_lutmem_q : STD_LOGIC_VECTOR (8 downto 0);
    signal u0_m0_wo0_oseq_gated_a : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_oseq_gated_b : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_oseq_gated_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xIn_bankIn_0_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_ra0_resize_in : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_ra0_resize_b : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_ra1_resize_in : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_ra1_resize_b : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_cab0_q : STD_LOGIC_VECTOR (9 downto 0);
    signal bank_u0_m0_wi0_wo0_in : STD_LOGIC_VECTOR (13 downto 0);
    signal bank_u0_m0_wi0_wo0_b : STD_LOGIC_VECTOR (1 downto 0);
    signal data_u0_m0_wi0_wo0_in : STD_LOGIC_VECTOR (11 downto 0);
    signal data_u0_m0_wi0_wo0_b : STD_LOGIC_VECTOR (11 downto 0);

begin


    -- VCC(CONSTANT,1)@0
    VCC_q <= "1";

    -- xIn(PORTIN,2)@10

    -- u0_m0_wo0_run(ENABLEGENERATOR,8)@10
    u0_m0_wo0_run_ctrl <= u0_m0_wo0_run_out & xIn_v & u0_m0_wo0_run_enable_q;
    u0_m0_wo0_run: PROCESS (clk, areset)
        variable u0_m0_wo0_run_enable_c : SIGNED(8 downto 0);
        variable u0_m0_wo0_run_inc : SIGNED(1 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_run_q <= "0";
            u0_m0_wo0_run_enable_c := TO_SIGNED(138, 9);
            u0_m0_wo0_run_enable_q <= "0";
            u0_m0_wo0_run_count <= "00";
            u0_m0_wo0_run_inc := (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_run_out = "1") THEN
                IF (u0_m0_wo0_run_enable_c(8) = '1') THEN
                    u0_m0_wo0_run_enable_c := u0_m0_wo0_run_enable_c - (-139);
                ELSE
                    u0_m0_wo0_run_enable_c := u0_m0_wo0_run_enable_c + (-1);
                END IF;
                u0_m0_wo0_run_enable_q <= STD_LOGIC_VECTOR(u0_m0_wo0_run_enable_c(8 downto 8));
            ELSE
                u0_m0_wo0_run_enable_q <= "0";
            END IF;
            CASE (u0_m0_wo0_run_ctrl) IS
                WHEN "000" | "001" => u0_m0_wo0_run_inc := "00";
                WHEN "010" | "011" => u0_m0_wo0_run_inc := "11";
                WHEN "100" => u0_m0_wo0_run_inc := "00";
                WHEN "101" => u0_m0_wo0_run_inc := "01";
                WHEN "110" => u0_m0_wo0_run_inc := "11";
                WHEN "111" => u0_m0_wo0_run_inc := "00";
                WHEN OTHERS => 
            END CASE;
            u0_m0_wo0_run_count <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_run_count) + SIGNED(u0_m0_wo0_run_inc));
            u0_m0_wo0_run_q <= u0_m0_wo0_run_out;
        END IF;
    END PROCESS;
    u0_m0_wo0_run_pre_ena_q <= u0_m0_wo0_run_count(1 downto 1);
    u0_m0_wo0_run_out <= u0_m0_wo0_run_pre_ena_q and VCC_q;

    -- u0_m0_wo0_memread(DELAY,9)@12
    u0_m0_wo0_memread : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_run_q, xout => u0_m0_wo0_memread_q, clk => clk, aclr => areset );

    -- d_u0_m0_wo0_memread_q_14(DELAY,49)@12
    d_u0_m0_wo0_memread_q_14 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2 )
    PORT MAP ( xin => u0_m0_wo0_memread_q, xout => d_u0_m0_wo0_memread_q_14_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_compute(DELAY,10)@14
    u0_m0_wo0_compute : dspba_delay
    GENERIC MAP ( width => 1, depth => 2 )
    PORT MAP ( xin => d_u0_m0_wo0_memread_q_14_q, xout => u0_m0_wo0_compute_q, clk => clk, aclr => areset );

    -- d_u0_m0_wo0_compute_q_15(DELAY,50)@14
    d_u0_m0_wo0_compute_q_15 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_compute_q, xout => d_u0_m0_wo0_compute_q_15_q, clk => clk, aclr => areset );

    -- d_u0_m0_wo0_compute_q_17(DELAY,51)@15
    d_u0_m0_wo0_compute_q_17 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2 )
    PORT MAP ( xin => d_u0_m0_wo0_compute_q_15_q, xout => d_u0_m0_wo0_compute_q_17_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_aseq(SEQUENCE,36)@17
    u0_m0_wo0_aseq: PROCESS (clk, areset)
        variable u0_m0_wo0_aseq_c : SIGNED(9 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_aseq_c := "0000000000";
            u0_m0_wo0_aseq_q <= "0";
            u0_m0_wo0_aseq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_17_q = "1") THEN
                IF (u0_m0_wo0_aseq_c = "0000000000") THEN
                    u0_m0_wo0_aseq_eq <= '1';
                ELSE
                    u0_m0_wo0_aseq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_aseq_eq = '1') THEN
                    u0_m0_wo0_aseq_c := u0_m0_wo0_aseq_c + 139;
                ELSE
                    u0_m0_wo0_aseq_c := u0_m0_wo0_aseq_c - 1;
                END IF;
                u0_m0_wo0_aseq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_aseq_c(9 downto 9));
            END IF;
        END IF;
    END PROCESS;

    -- d_u0_m0_wo0_compute_q_18(DELAY,52)@17
    d_u0_m0_wo0_compute_q_18 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => d_u0_m0_wo0_compute_q_17_q, xout => d_u0_m0_wo0_compute_q_18_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_symSuppress_0_seq(SEQUENCE,33)@14
    u0_m0_wo0_symSuppress_0_seq: PROCESS (clk, areset)
        variable u0_m0_wo0_symSuppress_0_seq_c : SIGNED(9 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_symSuppress_0_seq_c := "0000000000";
            u0_m0_wo0_symSuppress_0_seq_q <= "0";
            u0_m0_wo0_symSuppress_0_seq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_compute_q = "1") THEN
                IF (u0_m0_wo0_symSuppress_0_seq_c = "0000000000") THEN
                    u0_m0_wo0_symSuppress_0_seq_eq <= '1';
                ELSE
                    u0_m0_wo0_symSuppress_0_seq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_symSuppress_0_seq_eq = '1') THEN
                    u0_m0_wo0_symSuppress_0_seq_c := u0_m0_wo0_symSuppress_0_seq_c + 139;
                ELSE
                    u0_m0_wo0_symSuppress_0_seq_c := u0_m0_wo0_symSuppress_0_seq_c - 1;
                END IF;
                u0_m0_wo0_symSuppress_0_seq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_symSuppress_0_seq_c(9 downto 9));
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_wa1(COUNTER,22)@15
    -- every=1, low=0, high=255, step=1, init=24
    u0_m0_wo0_wi0_wa1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_wa1_i <= TO_UNSIGNED(24, 8);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_wi0_we1_seq_q = "1") THEN
                u0_m0_wo0_wi0_wa1_i <= u0_m0_wo0_wi0_wa1_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_wa1_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_wa1_i, 8)));

    -- u0_m0_wo0_wi0_we1_seq(SEQUENCE,20)@14
    u0_m0_wo0_wi0_we1_seq: PROCESS (clk, areset)
        variable u0_m0_wo0_wi0_we1_seq_c : SIGNED(9 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_we1_seq_c := "0000000000";
            u0_m0_wo0_wi0_we1_seq_q <= "0";
            u0_m0_wo0_wi0_we1_seq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_compute_q = "1") THEN
                IF (u0_m0_wo0_wi0_we1_seq_c = "0000000000") THEN
                    u0_m0_wo0_wi0_we1_seq_eq <= '1';
                ELSE
                    u0_m0_wo0_wi0_we1_seq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_wi0_we1_seq_eq = '1') THEN
                    u0_m0_wo0_wi0_we1_seq_c := u0_m0_wo0_wi0_we1_seq_c + 139;
                ELSE
                    u0_m0_wo0_wi0_we1_seq_c := u0_m0_wo0_wi0_we1_seq_c - 1;
                END IF;
                u0_m0_wo0_wi0_we1_seq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_we1_seq_c(9 downto 9));
            ELSE
                u0_m0_wo0_wi0_we1_seq_q <= "0";
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_ra1_count1(COUNTER,16)@12
    -- every=1, low=0, high=139, step=1, init=0
    u0_m0_wo0_wi0_ra1_count1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_ra1_count1_i <= TO_UNSIGNED(0, 8);
            u0_m0_wo0_wi0_ra1_count1_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_memread_q = "1") THEN
                IF (u0_m0_wo0_wi0_ra1_count1_i = TO_UNSIGNED(138, 8)) THEN
                    u0_m0_wo0_wi0_ra1_count1_eq <= '1';
                ELSE
                    u0_m0_wo0_wi0_ra1_count1_eq <= '0';
                END IF;
                IF (u0_m0_wo0_wi0_ra1_count1_eq = '1') THEN
                    u0_m0_wo0_wi0_ra1_count1_i <= u0_m0_wo0_wi0_ra1_count1_i - 139;
                ELSE
                    u0_m0_wo0_wi0_ra1_count1_i <= u0_m0_wo0_wi0_ra1_count1_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_ra1_count1_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_ra1_count1_i, 8)));

    -- u0_m0_wo0_wi0_ra1_count1_lut_lutmem(DUALMEM,45)@12
    u0_m0_wo0_wi0_ra1_count1_lut_lutmem_ia <= (others => '0');
    u0_m0_wo0_wi0_ra1_count1_lut_lutmem_aa <= (others => '0');
    u0_m0_wo0_wi0_ra1_count1_lut_lutmem_ab <= u0_m0_wo0_wi0_ra1_count1_q;
    u0_m0_wo0_wi0_ra1_count1_lut_lutmem_reset0 <= areset;
    u0_m0_wo0_wi0_ra1_count1_lut_lutmem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "M9K",
        operation_mode => "DUAL_PORT",
        width_a => 9,
        widthad_a => 8,
        numwords_a => 140,
        width_b => 9,
        widthad_b => 8,
        numwords_b => 140,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "CLEAR0",
        address_reg_b => "CLOCK0",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "quad_bank_fir_rtl_u0_m0_wo0_wi0_ra1_count1_lut_lutmem.hex",
        init_file_layout => "PORT_B",
        intended_device_family => "Cyclone III"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        wren_a => '0',
        aclr0 => u0_m0_wo0_wi0_ra1_count1_lut_lutmem_reset0,
        clock0 => clk,
        address_b => u0_m0_wo0_wi0_ra1_count1_lut_lutmem_ab,
        q_b => u0_m0_wo0_wi0_ra1_count1_lut_lutmem_iq,
        address_a => u0_m0_wo0_wi0_ra1_count1_lut_lutmem_aa,
        data_a => u0_m0_wo0_wi0_ra1_count1_lut_lutmem_ia
    );
    u0_m0_wo0_wi0_ra1_count1_lut_lutmem_q <= u0_m0_wo0_wi0_ra1_count1_lut_lutmem_iq(8 downto 0);

    -- u0_m0_wo0_wi0_ra1_count0(COUNTER,15)@14
    -- every=140, low=0, high=255, step=1, init=0
    u0_m0_wo0_wi0_ra1_count0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_ra1_count0_i <= TO_UNSIGNED(0, 8);
            u0_m0_wo0_wi0_ra1_count0_sc <= TO_SIGNED(138, 9);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_memread_q_14_q = "1") THEN
                IF (u0_m0_wo0_wi0_ra1_count0_sc(8) = '1') THEN
                    u0_m0_wo0_wi0_ra1_count0_sc <= u0_m0_wo0_wi0_ra1_count0_sc - (-139);
                ELSE
                    u0_m0_wo0_wi0_ra1_count0_sc <= u0_m0_wo0_wi0_ra1_count0_sc + (-1);
                END IF;
                IF (u0_m0_wo0_wi0_ra1_count0_sc(8) = '1') THEN
                    u0_m0_wo0_wi0_ra1_count0_i <= u0_m0_wo0_wi0_ra1_count0_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_ra1_count0_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_ra1_count0_i, 9)));

    -- u0_m0_wo0_wi0_ra1_add_0_0(ADD,18)@14
    u0_m0_wo0_wi0_ra1_add_0_0_a <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_ra1_count0_q);
    u0_m0_wo0_wi0_ra1_add_0_0_b <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_ra1_count1_lut_lutmem_q);
    u0_m0_wo0_wi0_ra1_add_0_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_ra1_add_0_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_ra1_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(u0_m0_wo0_wi0_ra1_add_0_0_a) + UNSIGNED(u0_m0_wo0_wi0_ra1_add_0_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_ra1_add_0_0_q <= u0_m0_wo0_wi0_ra1_add_0_0_o(9 downto 0);

    -- u0_m0_wo0_wi0_ra1_resize(BITSELECT,19)@15
    u0_m0_wo0_wi0_ra1_resize_in <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_ra1_add_0_0_q(7 downto 0));
    u0_m0_wo0_wi0_ra1_resize_b <= u0_m0_wo0_wi0_ra1_resize_in(7 downto 0);

    -- u0_m0_wo0_wi0_delayr1(DUALMEM,25)@15
    u0_m0_wo0_wi0_delayr1_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr0_q);
    u0_m0_wo0_wi0_delayr1_aa <= u0_m0_wo0_wi0_wa1_q;
    u0_m0_wo0_wi0_delayr1_ab <= u0_m0_wo0_wi0_ra1_resize_b;
    u0_m0_wo0_wi0_delayr1_reset0 <= areset;
    u0_m0_wo0_wi0_delayr1_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "M9K",
        operation_mode => "DUAL_PORT",
        width_a => 12,
        widthad_a => 8,
        numwords_a => 256,
        width_b => 12,
        widthad_b => 8,
        numwords_b => 256,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "CLEAR0",
        address_reg_b => "CLOCK0",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "OLD_DATA",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Cyclone III"
    )
    PORT MAP (
        clocken0 => '1',
        wren_a => u0_m0_wo0_wi0_we1_seq_q(0),
        aclr0 => u0_m0_wo0_wi0_delayr1_reset0,
        clock0 => clk,
        address_b => u0_m0_wo0_wi0_delayr1_ab,
        q_b => u0_m0_wo0_wi0_delayr1_iq,
        address_a => u0_m0_wo0_wi0_delayr1_aa,
        data_a => u0_m0_wo0_wi0_delayr1_ia
    );
    u0_m0_wo0_wi0_delayr1_q <= u0_m0_wo0_wi0_delayr1_iq(11 downto 0);

    -- d_xIn_bankIn_0_15(DELAY,47)@10
    d_xIn_bankIn_0_15 : dspba_delay
    GENERIC MAP ( width => 2, depth => 5 )
    PORT MAP ( xin => bankIn_0, xout => d_xIn_bankIn_0_15_q, clk => clk, aclr => areset );

    -- d_xIn_0_15(DELAY,46)@10
    d_xIn_0_15 : dspba_delay
    GENERIC MAP ( width => 12, depth => 5 )
    PORT MAP ( xin => xIn_0, xout => d_xIn_0_15_q, clk => clk, aclr => areset );

    -- xIn_bankIn_0(BITJOIN,3)@15
    xIn_bankIn_0_q <= d_xIn_bankIn_0_15_q & d_xIn_0_15_q;

    -- data_u0_m0_wi0_wo0(BITSELECT,7)@15
    data_u0_m0_wi0_wo0_in <= STD_LOGIC_VECTOR(xIn_bankIn_0_q(11 downto 0));
    data_u0_m0_wi0_wo0_b <= data_u0_m0_wi0_wo0_in(11 downto 0);

    -- u0_m0_wo0_wi0_wa0(COUNTER,21)@15
    -- every=1, low=0, high=255, step=1, init=23
    u0_m0_wo0_wi0_wa0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_wa0_i <= TO_UNSIGNED(23, 8);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_in0_m0_wi0_wo0_assign_sel_q_15_q = "1") THEN
                u0_m0_wo0_wi0_wa0_i <= u0_m0_wo0_wi0_wa0_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_wa0_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_wa0_i, 8)));

    -- d_in0_m0_wi0_wo0_assign_sel_q_15(DELAY,48)@10
    d_in0_m0_wi0_wo0_assign_sel_q_15 : dspba_delay
    GENERIC MAP ( width => 1, depth => 5 )
    PORT MAP ( xin => xIn_v, xout => d_in0_m0_wi0_wo0_assign_sel_q_15_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_ra0_count1(COUNTER,12)@14
    -- every=1, low=0, high=255, step=1, init=0
    u0_m0_wo0_wi0_ra0_count1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_ra0_count1_i <= TO_UNSIGNED(0, 8);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_memread_q_14_q = "1") THEN
                u0_m0_wo0_wi0_ra0_count1_i <= u0_m0_wo0_wi0_ra0_count1_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_ra0_count1_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_ra0_count1_i, 9)));

    -- u0_m0_wo0_wi0_ra0_count0(COUNTER,11)@14
    -- every=140, low=0, high=255, step=117, init=140
    u0_m0_wo0_wi0_ra0_count0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_ra0_count0_i <= TO_UNSIGNED(140, 8);
            u0_m0_wo0_wi0_ra0_count0_sc <= TO_SIGNED(138, 9);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_memread_q_14_q = "1") THEN
                IF (u0_m0_wo0_wi0_ra0_count0_sc(8) = '1') THEN
                    u0_m0_wo0_wi0_ra0_count0_sc <= u0_m0_wo0_wi0_ra0_count0_sc - (-139);
                ELSE
                    u0_m0_wo0_wi0_ra0_count0_sc <= u0_m0_wo0_wi0_ra0_count0_sc + (-1);
                END IF;
                IF (u0_m0_wo0_wi0_ra0_count0_sc(8) = '1') THEN
                    u0_m0_wo0_wi0_ra0_count0_i <= u0_m0_wo0_wi0_ra0_count0_i + 117;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_ra0_count0_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_ra0_count0_i, 9)));

    -- u0_m0_wo0_wi0_ra0_add_0_0(ADD,13)@14
    u0_m0_wo0_wi0_ra0_add_0_0_a <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_ra0_count0_q);
    u0_m0_wo0_wi0_ra0_add_0_0_b <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_ra0_count1_q);
    u0_m0_wo0_wi0_ra0_add_0_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_ra0_add_0_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_ra0_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(u0_m0_wo0_wi0_ra0_add_0_0_a) + UNSIGNED(u0_m0_wo0_wi0_ra0_add_0_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_ra0_add_0_0_q <= u0_m0_wo0_wi0_ra0_add_0_0_o(9 downto 0);

    -- u0_m0_wo0_wi0_ra0_resize(BITSELECT,14)@15
    u0_m0_wo0_wi0_ra0_resize_in <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_ra0_add_0_0_q(7 downto 0));
    u0_m0_wo0_wi0_ra0_resize_b <= u0_m0_wo0_wi0_ra0_resize_in(7 downto 0);

    -- u0_m0_wo0_wi0_delayr0(DUALMEM,23)@15
    u0_m0_wo0_wi0_delayr0_ia <= STD_LOGIC_VECTOR(data_u0_m0_wi0_wo0_b);
    u0_m0_wo0_wi0_delayr0_aa <= u0_m0_wo0_wi0_wa0_q;
    u0_m0_wo0_wi0_delayr0_ab <= u0_m0_wo0_wi0_ra0_resize_b;
    u0_m0_wo0_wi0_delayr0_reset0 <= areset;
    u0_m0_wo0_wi0_delayr0_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "M9K",
        operation_mode => "DUAL_PORT",
        width_a => 12,
        widthad_a => 8,
        numwords_a => 256,
        width_b => 12,
        widthad_b => 8,
        numwords_b => 256,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "CLEAR0",
        address_reg_b => "CLOCK0",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "OLD_DATA",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Cyclone III"
    )
    PORT MAP (
        clocken0 => '1',
        wren_a => d_in0_m0_wi0_wo0_assign_sel_q_15_q(0),
        aclr0 => u0_m0_wo0_wi0_delayr0_reset0,
        clock0 => clk,
        address_b => u0_m0_wo0_wi0_delayr0_ab,
        q_b => u0_m0_wo0_wi0_delayr0_iq,
        address_a => u0_m0_wo0_wi0_delayr0_aa,
        data_a => u0_m0_wo0_wi0_delayr0_ia
    );
    u0_m0_wo0_wi0_delayr0_q <= u0_m0_wo0_wi0_delayr0_iq(11 downto 0);

    -- u0_m0_wo0_sym_add0(ADD,34)@15
    u0_m0_wo0_sym_add0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((12 downto 12 => u0_m0_wo0_wi0_delayr0_q(11)) & u0_m0_wo0_wi0_delayr0_q));
    u0_m0_wo0_sym_add0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((12 downto 12 => u0_m0_wo0_wi0_delayr1_q(11)) & u0_m0_wo0_wi0_delayr1_q));
    u0_m0_wo0_sym_add0_i <= u0_m0_wo0_sym_add0_a;
    u0_m0_wo0_sym_add0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_sym_add0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_symSuppress_0_seq_q = "1") THEN
                u0_m0_wo0_sym_add0_o <= u0_m0_wo0_sym_add0_i;
            ELSE
                u0_m0_wo0_sym_add0_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_sym_add0_a) + SIGNED(u0_m0_wo0_sym_add0_b));
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_sym_add0_q <= u0_m0_wo0_sym_add0_o(12 downto 0);

    -- bank_u0_m0_wi0_wo0(BITSELECT,6)@15
    bank_u0_m0_wi0_wo0_in <= STD_LOGIC_VECTOR(xIn_bankIn_0_q);
    bank_u0_m0_wi0_wo0_b <= bank_u0_m0_wi0_wo0_in(13 downto 12);

    -- u0_m0_wo0_bank_delayr0(DUALMEM,28)@15
    u0_m0_wo0_bank_delayr0_ia <= bank_u0_m0_wi0_wo0_b;
    u0_m0_wo0_bank_delayr0_aa <= GND_q;
    u0_m0_wo0_bank_delayr0_ab <= GND_q;
    u0_m0_wo0_bank_delayr0_reset0 <= areset;
    u0_m0_wo0_bank_delayr0_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "M9K",
        operation_mode => "DUAL_PORT",
        width_a => 2,
        widthad_a => 1,
        numwords_a => 2,
        width_b => 2,
        widthad_b => 1,
        numwords_b => 2,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "CLEAR0",
        address_reg_b => "CLOCK0",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "OLD_DATA",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Cyclone III"
    )
    PORT MAP (
        clocken0 => '1',
        wren_a => d_in0_m0_wi0_wo0_assign_sel_q_15_q(0),
        aclr0 => u0_m0_wo0_bank_delayr0_reset0,
        clock0 => clk,
        address_b => u0_m0_wo0_bank_delayr0_ab,
        q_b => u0_m0_wo0_bank_delayr0_iq,
        address_a => u0_m0_wo0_bank_delayr0_aa,
        data_a => u0_m0_wo0_bank_delayr0_ia
    );
    u0_m0_wo0_bank_delayr0_q <= u0_m0_wo0_bank_delayr0_iq(1 downto 0);

    -- u0_m0_wo0_ca0(COUNTER,30)@15
    -- every=1, low=0, high=139, step=1, init=0
    u0_m0_wo0_ca0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_ca0_i <= TO_UNSIGNED(0, 8);
            u0_m0_wo0_ca0_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_15_q = "1") THEN
                IF (u0_m0_wo0_ca0_i = TO_UNSIGNED(138, 8)) THEN
                    u0_m0_wo0_ca0_eq <= '1';
                ELSE
                    u0_m0_wo0_ca0_eq <= '0';
                END IF;
                IF (u0_m0_wo0_ca0_eq = '1') THEN
                    u0_m0_wo0_ca0_i <= u0_m0_wo0_ca0_i - 139;
                ELSE
                    u0_m0_wo0_ca0_i <= u0_m0_wo0_ca0_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_ca0_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_ca0_i, 8)));

    -- u0_m0_wo0_cab0(BITJOIN,31)@15
    u0_m0_wo0_cab0_q <= u0_m0_wo0_bank_delayr0_q & u0_m0_wo0_ca0_q;

    -- u0_m0_wo0_cm0(LOOKUP,32)@15
    u0_m0_wo0_cm0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_cm0_q <= "01111111111111";
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (u0_m0_wo0_cab0_q) IS
                WHEN "0000000000" => u0_m0_wo0_cm0_q <= "01111111111111";
                WHEN "0000000001" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000000010" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000000011" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000000100" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000000101" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000000110" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000000111" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000001000" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000001001" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000001010" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000001011" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000001100" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000001101" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000001110" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000001111" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000010000" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000010001" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000010010" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000010011" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000010100" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000010101" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000010110" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000010111" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000011000" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000011001" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000011010" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000011011" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000011100" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000011101" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000011110" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000011111" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000100000" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000100001" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000100010" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000100011" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000100100" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000100101" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000100110" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000100111" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000101000" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000101001" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000101010" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000101011" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000101100" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000101101" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000101110" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000101111" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000110000" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000110001" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000110010" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000110011" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000110100" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000110101" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000110110" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000110111" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000111000" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000111001" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000111010" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000111011" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000111100" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000111101" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000111110" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0000111111" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001000000" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001000001" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001000010" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001000011" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001000100" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001000101" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001000110" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001000111" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001001000" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001001001" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001001010" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001001011" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001001100" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001001101" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001001110" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001001111" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001010000" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001010001" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001010010" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001010011" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001010100" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001010101" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001010110" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001010111" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001011000" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001011001" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001011010" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001011011" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001011100" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001011101" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001011110" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001011111" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001100000" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001100001" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001100010" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001100011" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001100100" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001100101" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001100110" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001100111" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001101000" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001101001" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001101010" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001101011" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001101100" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001101101" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001101110" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001101111" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001110000" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001110001" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001110010" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001110011" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001110100" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001110101" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001110110" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001110111" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001111000" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001111001" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001111010" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001111011" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001111100" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001111101" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001111110" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0001111111" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0010000000" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0010000001" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0010000010" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0010000011" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0010000100" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0010000101" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0010000110" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0010000111" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0010001000" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0010001001" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0010001010" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0010001011" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "0100000000" => u0_m0_wo0_cm0_q <= "01111111111110";
                WHEN "0100000001" => u0_m0_wo0_cm0_q <= "01111111101111";
                WHEN "0100000010" => u0_m0_wo0_cm0_q <= "01111111000010";
                WHEN "0100000011" => u0_m0_wo0_cm0_q <= "01111101110110";
                WHEN "0100000100" => u0_m0_wo0_cm0_q <= "01111100001110";
                WHEN "0100000101" => u0_m0_wo0_cm0_q <= "01111010001000";
                WHEN "0100000110" => u0_m0_wo0_cm0_q <= "01110111100111";
                WHEN "0100000111" => u0_m0_wo0_cm0_q <= "01110100101011";
                WHEN "0100001000" => u0_m0_wo0_cm0_q <= "01110001010110";
                WHEN "0100001001" => u0_m0_wo0_cm0_q <= "01101101101010";
                WHEN "0100001010" => u0_m0_wo0_cm0_q <= "01101001100111";
                WHEN "0100001011" => u0_m0_wo0_cm0_q <= "01100101010000";
                WHEN "0100001100" => u0_m0_wo0_cm0_q <= "01100000100111";
                WHEN "0100001101" => u0_m0_wo0_cm0_q <= "01011011101110";
                WHEN "0100001110" => u0_m0_wo0_cm0_q <= "01010110100111";
                WHEN "0100001111" => u0_m0_wo0_cm0_q <= "01010001010100";
                WHEN "0100010000" => u0_m0_wo0_cm0_q <= "01001011110111";
                WHEN "0100010001" => u0_m0_wo0_cm0_q <= "01000110010011";
                WHEN "0100010010" => u0_m0_wo0_cm0_q <= "01000000101010";
                WHEN "0100010011" => u0_m0_wo0_cm0_q <= "00111010111111";
                WHEN "0100010100" => u0_m0_wo0_cm0_q <= "00110101010011";
                WHEN "0100010101" => u0_m0_wo0_cm0_q <= "00101111101001";
                WHEN "0100010110" => u0_m0_wo0_cm0_q <= "00101010000011";
                WHEN "0100010111" => u0_m0_wo0_cm0_q <= "00100100100011";
                WHEN "0100011000" => u0_m0_wo0_cm0_q <= "00011111001011";
                WHEN "0100011001" => u0_m0_wo0_cm0_q <= "00011001111101";
                WHEN "0100011010" => u0_m0_wo0_cm0_q <= "00010100111011";
                WHEN "0100011011" => u0_m0_wo0_cm0_q <= "00010000000110";
                WHEN "0100011100" => u0_m0_wo0_cm0_q <= "00001011100000";
                WHEN "0100011101" => u0_m0_wo0_cm0_q <= "00000111001010";
                WHEN "0100011110" => u0_m0_wo0_cm0_q <= "00000011000101";
                WHEN "0100011111" => u0_m0_wo0_cm0_q <= "11111111010011";
                WHEN "0100100000" => u0_m0_wo0_cm0_q <= "11111011110100";
                WHEN "0100100001" => u0_m0_wo0_cm0_q <= "11111000101000";
                WHEN "0100100010" => u0_m0_wo0_cm0_q <= "11110101110000";
                WHEN "0100100011" => u0_m0_wo0_cm0_q <= "11110011001100";
                WHEN "0100100100" => u0_m0_wo0_cm0_q <= "11110000111101";
                WHEN "0100100101" => u0_m0_wo0_cm0_q <= "11101111000010";
                WHEN "0100100110" => u0_m0_wo0_cm0_q <= "11101101011011";
                WHEN "0100100111" => u0_m0_wo0_cm0_q <= "11101100001000";
                WHEN "0100101000" => u0_m0_wo0_cm0_q <= "11101011001000";
                WHEN "0100101001" => u0_m0_wo0_cm0_q <= "11101010011011";
                WHEN "0100101010" => u0_m0_wo0_cm0_q <= "11101010000000";
                WHEN "0100101011" => u0_m0_wo0_cm0_q <= "11101001110101";
                WHEN "0100101100" => u0_m0_wo0_cm0_q <= "11101001111010";
                WHEN "0100101101" => u0_m0_wo0_cm0_q <= "11101010001110";
                WHEN "0100101110" => u0_m0_wo0_cm0_q <= "11101010110000";
                WHEN "0100101111" => u0_m0_wo0_cm0_q <= "11101011011110";
                WHEN "0100110000" => u0_m0_wo0_cm0_q <= "11101100011000";
                WHEN "0100110001" => u0_m0_wo0_cm0_q <= "11101101011011";
                WHEN "0100110010" => u0_m0_wo0_cm0_q <= "11101110100111";
                WHEN "0100110011" => u0_m0_wo0_cm0_q <= "11101111111010";
                WHEN "0100110100" => u0_m0_wo0_cm0_q <= "11110001010100";
                WHEN "0100110101" => u0_m0_wo0_cm0_q <= "11110010110010";
                WHEN "0100110110" => u0_m0_wo0_cm0_q <= "11110100010011";
                WHEN "0100110111" => u0_m0_wo0_cm0_q <= "11110101110111";
                WHEN "0100111000" => u0_m0_wo0_cm0_q <= "11110111011100";
                WHEN "0100111001" => u0_m0_wo0_cm0_q <= "11111001000001";
                WHEN "0100111010" => u0_m0_wo0_cm0_q <= "11111010100101";
                WHEN "0100111011" => u0_m0_wo0_cm0_q <= "11111100000111";
                WHEN "0100111100" => u0_m0_wo0_cm0_q <= "11111101100110";
                WHEN "0100111101" => u0_m0_wo0_cm0_q <= "11111111000001";
                WHEN "0100111110" => u0_m0_wo0_cm0_q <= "00000000011000";
                WHEN "0100111111" => u0_m0_wo0_cm0_q <= "00000001101010";
                WHEN "0101000000" => u0_m0_wo0_cm0_q <= "00000010110111";
                WHEN "0101000001" => u0_m0_wo0_cm0_q <= "00000011111110";
                WHEN "0101000010" => u0_m0_wo0_cm0_q <= "00000100111110";
                WHEN "0101000011" => u0_m0_wo0_cm0_q <= "00000101111000";
                WHEN "0101000100" => u0_m0_wo0_cm0_q <= "00000110101100";
                WHEN "0101000101" => u0_m0_wo0_cm0_q <= "00000111011000";
                WHEN "0101000110" => u0_m0_wo0_cm0_q <= "00000111111110";
                WHEN "0101000111" => u0_m0_wo0_cm0_q <= "00001000011101";
                WHEN "0101001000" => u0_m0_wo0_cm0_q <= "00001000110110";
                WHEN "0101001001" => u0_m0_wo0_cm0_q <= "00001001001000";
                WHEN "0101001010" => u0_m0_wo0_cm0_q <= "00001001010100";
                WHEN "0101001011" => u0_m0_wo0_cm0_q <= "00001001011010";
                WHEN "0101001100" => u0_m0_wo0_cm0_q <= "00001001011011";
                WHEN "0101001101" => u0_m0_wo0_cm0_q <= "00001001010110";
                WHEN "0101001110" => u0_m0_wo0_cm0_q <= "00001001001101";
                WHEN "0101001111" => u0_m0_wo0_cm0_q <= "00001001000000";
                WHEN "0101010000" => u0_m0_wo0_cm0_q <= "00001000101110";
                WHEN "0101010001" => u0_m0_wo0_cm0_q <= "00001000011001";
                WHEN "0101010010" => u0_m0_wo0_cm0_q <= "00001000000001";
                WHEN "0101010011" => u0_m0_wo0_cm0_q <= "00000111100111";
                WHEN "0101010100" => u0_m0_wo0_cm0_q <= "00000111001011";
                WHEN "0101010101" => u0_m0_wo0_cm0_q <= "00000110101100";
                WHEN "0101010110" => u0_m0_wo0_cm0_q <= "00000110001101";
                WHEN "0101010111" => u0_m0_wo0_cm0_q <= "00000101101101";
                WHEN "0101011000" => u0_m0_wo0_cm0_q <= "00000101001101";
                WHEN "0101011001" => u0_m0_wo0_cm0_q <= "00000100101100";
                WHEN "0101011010" => u0_m0_wo0_cm0_q <= "00000100001100";
                WHEN "0101011011" => u0_m0_wo0_cm0_q <= "00000011101101";
                WHEN "0101011100" => u0_m0_wo0_cm0_q <= "00000011001110";
                WHEN "0101011101" => u0_m0_wo0_cm0_q <= "00000010110000";
                WHEN "0101011110" => u0_m0_wo0_cm0_q <= "00000010010100";
                WHEN "0101011111" => u0_m0_wo0_cm0_q <= "00000001111001";
                WHEN "0101100000" => u0_m0_wo0_cm0_q <= "00000001100000";
                WHEN "0101100001" => u0_m0_wo0_cm0_q <= "00000001001000";
                WHEN "0101100010" => u0_m0_wo0_cm0_q <= "00000000110010";
                WHEN "0101100011" => u0_m0_wo0_cm0_q <= "00000000011110";
                WHEN "0101100100" => u0_m0_wo0_cm0_q <= "00000000001100";
                WHEN "0101100101" => u0_m0_wo0_cm0_q <= "11111111111101";
                WHEN "0101100110" => u0_m0_wo0_cm0_q <= "11111111101111";
                WHEN "0101100111" => u0_m0_wo0_cm0_q <= "11111111100011";
                WHEN "0101101000" => u0_m0_wo0_cm0_q <= "11111111011000";
                WHEN "0101101001" => u0_m0_wo0_cm0_q <= "11111111001111";
                WHEN "0101101010" => u0_m0_wo0_cm0_q <= "11111111001000";
                WHEN "0101101011" => u0_m0_wo0_cm0_q <= "11111111000010";
                WHEN "0101101100" => u0_m0_wo0_cm0_q <= "11111110111110";
                WHEN "0101101101" => u0_m0_wo0_cm0_q <= "11111110111011";
                WHEN "0101101110" => u0_m0_wo0_cm0_q <= "11111110111001";
                WHEN "0101101111" => u0_m0_wo0_cm0_q <= "11111110111001";
                WHEN "0101110000" => u0_m0_wo0_cm0_q <= "11111110111001";
                WHEN "0101110001" => u0_m0_wo0_cm0_q <= "11111110111010";
                WHEN "0101110010" => u0_m0_wo0_cm0_q <= "11111110111100";
                WHEN "0101110011" => u0_m0_wo0_cm0_q <= "11111110111110";
                WHEN "0101110100" => u0_m0_wo0_cm0_q <= "11111111000001";
                WHEN "0101110101" => u0_m0_wo0_cm0_q <= "11111111000100";
                WHEN "0101110110" => u0_m0_wo0_cm0_q <= "11111111001000";
                WHEN "0101110111" => u0_m0_wo0_cm0_q <= "11111111001100";
                WHEN "0101111000" => u0_m0_wo0_cm0_q <= "11111111010000";
                WHEN "0101111001" => u0_m0_wo0_cm0_q <= "11111111010100";
                WHEN "0101111010" => u0_m0_wo0_cm0_q <= "11111111011000";
                WHEN "0101111011" => u0_m0_wo0_cm0_q <= "11111111011011";
                WHEN "0101111100" => u0_m0_wo0_cm0_q <= "11111111011111";
                WHEN "0101111101" => u0_m0_wo0_cm0_q <= "11111111100011";
                WHEN "0101111110" => u0_m0_wo0_cm0_q <= "11111111100110";
                WHEN "0101111111" => u0_m0_wo0_cm0_q <= "11111111101010";
                WHEN "0110000000" => u0_m0_wo0_cm0_q <= "11111111101101";
                WHEN "0110000001" => u0_m0_wo0_cm0_q <= "11111111101111";
                WHEN "0110000010" => u0_m0_wo0_cm0_q <= "11111111110010";
                WHEN "0110000011" => u0_m0_wo0_cm0_q <= "11111111110100";
                WHEN "0110000100" => u0_m0_wo0_cm0_q <= "11111111110110";
                WHEN "0110000101" => u0_m0_wo0_cm0_q <= "11111111111000";
                WHEN "0110000110" => u0_m0_wo0_cm0_q <= "11111111111010";
                WHEN "0110000111" => u0_m0_wo0_cm0_q <= "11111111111011";
                WHEN "0110001000" => u0_m0_wo0_cm0_q <= "11111111111100";
                WHEN "0110001001" => u0_m0_wo0_cm0_q <= "11111111111101";
                WHEN "0110001010" => u0_m0_wo0_cm0_q <= "11111111111110";
                WHEN "0110001011" => u0_m0_wo0_cm0_q <= "11111111111101";
                WHEN "1000000000" => u0_m0_wo0_cm0_q <= "01111111111110";
                WHEN "1000000001" => u0_m0_wo0_cm0_q <= "01111010001110";
                WHEN "1000000010" => u0_m0_wo0_cm0_q <= "01101001100010";
                WHEN "1000000011" => u0_m0_wo0_cm0_q <= "01001111101100";
                WHEN "1000000100" => u0_m0_wo0_cm0_q <= "00101111011000";
                WHEN "1000000101" => u0_m0_wo0_cm0_q <= "00001011111000";
                WHEN "1000000110" => u0_m0_wo0_cm0_q <= "11101000110001";
                WHEN "1000000111" => u0_m0_wo0_cm0_q <= "11001001011100";
                WHEN "1000001000" => u0_m0_wo0_cm0_q <= "10110000101111";
                WHEN "1000001001" => u0_m0_wo0_cm0_q <= "10100000101101";
                WHEN "1000001010" => u0_m0_wo0_cm0_q <= "10011010010110";
                WHEN "1000001011" => u0_m0_wo0_cm0_q <= "10011101100101";
                WHEN "1000001100" => u0_m0_wo0_cm0_q <= "10101001010100";
                WHEN "1000001101" => u0_m0_wo0_cm0_q <= "10111011100110";
                WHEN "1000001110" => u0_m0_wo0_cm0_q <= "11010001111100";
                WHEN "1000001111" => u0_m0_wo0_cm0_q <= "11101001101000";
                WHEN "1000010000" => u0_m0_wo0_cm0_q <= "00000000000011";
                WHEN "1000010001" => u0_m0_wo0_cm0_q <= "00010011000011";
                WHEN "1000010010" => u0_m0_wo0_cm0_q <= "00100001000001";
                WHEN "1000010011" => u0_m0_wo0_cm0_q <= "00101001001101";
                WHEN "1000010100" => u0_m0_wo0_cm0_q <= "00101011100111";
                WHEN "1000010101" => u0_m0_wo0_cm0_q <= "00101000111101";
                WHEN "1000010110" => u0_m0_wo0_cm0_q <= "00100010100010";
                WHEN "1000010111" => u0_m0_wo0_cm0_q <= "00011001111010";
                WHEN "1000011000" => u0_m0_wo0_cm0_q <= "00010000110001";
                WHEN "1000011001" => u0_m0_wo0_cm0_q <= "00001000100110";
                WHEN "1000011010" => u0_m0_wo0_cm0_q <= "00000010100011";
                WHEN "1000011011" => u0_m0_wo0_cm0_q <= "11111111001111";
                WHEN "1000011100" => u0_m0_wo0_cm0_q <= "11111110110001";
                WHEN "1000011101" => u0_m0_wo0_cm0_q <= "00000000101110";
                WHEN "1000011110" => u0_m0_wo0_cm0_q <= "00000100010110";
                WHEN "1000011111" => u0_m0_wo0_cm0_q <= "00001000100101";
                WHEN "1000100000" => u0_m0_wo0_cm0_q <= "00001100010110";
                WHEN "1000100001" => u0_m0_wo0_cm0_q <= "00001110101110";
                WHEN "1000100010" => u0_m0_wo0_cm0_q <= "00001110111111";
                WHEN "1000100011" => u0_m0_wo0_cm0_q <= "00001100111000";
                WHEN "1000100100" => u0_m0_wo0_cm0_q <= "00001000011110";
                WHEN "1000100101" => u0_m0_wo0_cm0_q <= "00000010010010";
                WHEN "1000100110" => u0_m0_wo0_cm0_q <= "11111011000101";
                WHEN "1000100111" => u0_m0_wo0_cm0_q <= "11110011110010";
                WHEN "1000101000" => u0_m0_wo0_cm0_q <= "11101101010111";
                WHEN "1000101001" => u0_m0_wo0_cm0_q <= "11101000101010";
                WHEN "1000101010" => u0_m0_wo0_cm0_q <= "11100110001110";
                WHEN "1000101011" => u0_m0_wo0_cm0_q <= "11100110010101";
                WHEN "1000101100" => u0_m0_wo0_cm0_q <= "11101000110111";
                WHEN "1000101101" => u0_m0_wo0_cm0_q <= "11101101011011";
                WHEN "1000101110" => u0_m0_wo0_cm0_q <= "11110011010110";
                WHEN "1000101111" => u0_m0_wo0_cm0_q <= "11111001110100";
                WHEN "1000110000" => u0_m0_wo0_cm0_q <= "00000000000000";
                WHEN "1000110001" => u0_m0_wo0_cm0_q <= "00000101001100";
                WHEN "1000110010" => u0_m0_wo0_cm0_q <= "00001000110111";
                WHEN "1000110011" => u0_m0_wo0_cm0_q <= "00001010110001";
                WHEN "1000110100" => u0_m0_wo0_cm0_q <= "00001010111011";
                WHEN "1000110101" => u0_m0_wo0_cm0_q <= "00001001101000";
                WHEN "1000110110" => u0_m0_wo0_cm0_q <= "00000111010111";
                WHEN "1000110111" => u0_m0_wo0_cm0_q <= "00000100101101";
                WHEN "1000111000" => u0_m0_wo0_cm0_q <= "00000010010001";
                WHEN "1000111001" => u0_m0_wo0_cm0_q <= "00000000100010";
                WHEN "1000111010" => u0_m0_wo0_cm0_q <= "11111111110111";
                WHEN "1000111011" => u0_m0_wo0_cm0_q <= "00000000010110";
                WHEN "1000111100" => u0_m0_wo0_cm0_q <= "00000001111001";
                WHEN "1000111101" => u0_m0_wo0_cm0_q <= "00000100001100";
                WHEN "1000111110" => u0_m0_wo0_cm0_q <= "00000110110010";
                WHEN "1000111111" => u0_m0_wo0_cm0_q <= "00001001001011";
                WHEN "1001000000" => u0_m0_wo0_cm0_q <= "00001010110111";
                WHEN "1001000001" => u0_m0_wo0_cm0_q <= "00001011011100";
                WHEN "1001000010" => u0_m0_wo0_cm0_q <= "00001010101110";
                WHEN "1001000011" => u0_m0_wo0_cm0_q <= "00001000101010";
                WHEN "1001000100" => u0_m0_wo0_cm0_q <= "00000101011100";
                WHEN "1001000101" => u0_m0_wo0_cm0_q <= "00000001011011";
                WHEN "1001000110" => u0_m0_wo0_cm0_q <= "11111101000110";
                WHEN "1001000111" => u0_m0_wo0_cm0_q <= "11111000111111";
                WHEN "1001001000" => u0_m0_wo0_cm0_q <= "11110101100100";
                WHEN "1001001001" => u0_m0_wo0_cm0_q <= "11110011001111";
                WHEN "1001001010" => u0_m0_wo0_cm0_q <= "11110010001111";
                WHEN "1001001011" => u0_m0_wo0_cm0_q <= "11110010101000";
                WHEN "1001001100" => u0_m0_wo0_cm0_q <= "11110100010000";
                WHEN "1001001101" => u0_m0_wo0_cm0_q <= "11110110110100";
                WHEN "1001001110" => u0_m0_wo0_cm0_q <= "11111001111011";
                WHEN "1001001111" => u0_m0_wo0_cm0_q <= "11111101000111";
                WHEN "1001010000" => u0_m0_wo0_cm0_q <= "11111111111100";
                WHEN "1001010001" => u0_m0_wo0_cm0_q <= "00000010000100";
                WHEN "1001010010" => u0_m0_wo0_cm0_q <= "00000011010011";
                WHEN "1001010011" => u0_m0_wo0_cm0_q <= "00000011100110";
                WHEN "1001010100" => u0_m0_wo0_cm0_q <= "00000011000011";
                WHEN "1001010101" => u0_m0_wo0_cm0_q <= "00000001111011";
                WHEN "1001010110" => u0_m0_wo0_cm0_q <= "00000000100011";
                WHEN "1001010111" => u0_m0_wo0_cm0_q <= "11111111010100";
                WHEN "1001011000" => u0_m0_wo0_cm0_q <= "11111110100001";
                WHEN "1001011001" => u0_m0_wo0_cm0_q <= "11111110011011";
                WHEN "1001011010" => u0_m0_wo0_cm0_q <= "11111111001010";
                WHEN "1001011011" => u0_m0_wo0_cm0_q <= "00000000101100";
                WHEN "1001011100" => u0_m0_wo0_cm0_q <= "00000010110111";
                WHEN "1001011101" => u0_m0_wo0_cm0_q <= "00000101011001";
                WHEN "1001011110" => u0_m0_wo0_cm0_q <= "00000111111001";
                WHEN "1001011111" => u0_m0_wo0_cm0_q <= "00001001111101";
                WHEN "1001100000" => u0_m0_wo0_cm0_q <= "00001011010000";
                WHEN "1001100001" => u0_m0_wo0_cm0_q <= "00001011011111";
                WHEN "1001100010" => u0_m0_wo0_cm0_q <= "00001010100010";
                WHEN "1001100011" => u0_m0_wo0_cm0_q <= "00001000011000";
                WHEN "1001100100" => u0_m0_wo0_cm0_q <= "00000101001101";
                WHEN "1001100101" => u0_m0_wo0_cm0_q <= "00000001010100";
                WHEN "1001100110" => u0_m0_wo0_cm0_q <= "11111101001000";
                WHEN "1001100111" => u0_m0_wo0_cm0_q <= "11111001000010";
                WHEN "1001101000" => u0_m0_wo0_cm0_q <= "11110101100000";
                WHEN "1001101001" => u0_m0_wo0_cm0_q <= "11110010111001";
                WHEN "1001101010" => u0_m0_wo0_cm0_q <= "11110001100000";
                WHEN "1001101011" => u0_m0_wo0_cm0_q <= "11110001011100";
                WHEN "1001101100" => u0_m0_wo0_cm0_q <= "11110010101100";
                WHEN "1001101101" => u0_m0_wo0_cm0_q <= "11110101000110";
                WHEN "1001101110" => u0_m0_wo0_cm0_q <= "11111000011000";
                WHEN "1001101111" => u0_m0_wo0_cm0_q <= "11111100001011";
                WHEN "1001110000" => u0_m0_wo0_cm0_q <= "00000000000100";
                WHEN "1001110001" => u0_m0_wo0_cm0_q <= "00000011101100";
                WHEN "1001110010" => u0_m0_wo0_cm0_q <= "00000110101110";
                WHEN "1001110011" => u0_m0_wo0_cm0_q <= "00001000111001";
                WHEN "1001110100" => u0_m0_wo0_cm0_q <= "00001010000100";
                WHEN "1001110101" => u0_m0_wo0_cm0_q <= "00001010001110";
                WHEN "1001110110" => u0_m0_wo0_cm0_q <= "00001001011101";
                WHEN "1001110111" => u0_m0_wo0_cm0_q <= "00000111111011";
                WHEN "1001111000" => u0_m0_wo0_cm0_q <= "00000101111000";
                WHEN "1001111001" => u0_m0_wo0_cm0_q <= "00000011100101";
                WHEN "1001111010" => u0_m0_wo0_cm0_q <= "00000001010010";
                WHEN "1001111011" => u0_m0_wo0_cm0_q <= "11111111001111";
                WHEN "1001111100" => u0_m0_wo0_cm0_q <= "11111101100101";
                WHEN "1001111101" => u0_m0_wo0_cm0_q <= "11111100011010";
                WHEN "1001111110" => u0_m0_wo0_cm0_q <= "11111011110011";
                WHEN "1001111111" => u0_m0_wo0_cm0_q <= "11111011101100";
                WHEN "1010000000" => u0_m0_wo0_cm0_q <= "11111100000001";
                WHEN "1010000001" => u0_m0_wo0_cm0_q <= "11111100101010";
                WHEN "1010000010" => u0_m0_wo0_cm0_q <= "11111101011111";
                WHEN "1010000011" => u0_m0_wo0_cm0_q <= "11111110011000";
                WHEN "1010000100" => u0_m0_wo0_cm0_q <= "11111111001101";
                WHEN "1010000101" => u0_m0_wo0_cm0_q <= "11111111111010";
                WHEN "1010000110" => u0_m0_wo0_cm0_q <= "00000000011011";
                WHEN "1010000111" => u0_m0_wo0_cm0_q <= "00000000101111";
                WHEN "1010001000" => u0_m0_wo0_cm0_q <= "00000000111000";
                WHEN "1010001001" => u0_m0_wo0_cm0_q <= "00000000110111";
                WHEN "1010001010" => u0_m0_wo0_cm0_q <= "00000000101110";
                WHEN "1010001011" => u0_m0_wo0_cm0_q <= "00000001000001";
                WHEN "1100000000" => u0_m0_wo0_cm0_q <= "01111111111111";
                WHEN "1100000001" => u0_m0_wo0_cm0_q <= "11101110110000";
                WHEN "1100000010" => u0_m0_wo0_cm0_q <= "11110000000000";
                WHEN "1100000011" => u0_m0_wo0_cm0_q <= "11110001111100";
                WHEN "1100000100" => u0_m0_wo0_cm0_q <= "11110100011011";
                WHEN "1100000101" => u0_m0_wo0_cm0_q <= "11110111010001";
                WHEN "1100000110" => u0_m0_wo0_cm0_q <= "11111010001101";
                WHEN "1100000111" => u0_m0_wo0_cm0_q <= "11111101000000";
                WHEN "1100001000" => u0_m0_wo0_cm0_q <= "11111111011111";
                WHEN "1100001001" => u0_m0_wo0_cm0_q <= "00000001011110";
                WHEN "1100001010" => u0_m0_wo0_cm0_q <= "00000010111000";
                WHEN "1100001011" => u0_m0_wo0_cm0_q <= "00000011101001";
                WHEN "1100001100" => u0_m0_wo0_cm0_q <= "00000011110011";
                WHEN "1100001101" => u0_m0_wo0_cm0_q <= "00000011011100";
                WHEN "1100001110" => u0_m0_wo0_cm0_q <= "00000010101010";
                WHEN "1100001111" => u0_m0_wo0_cm0_q <= "00000001101001";
                WHEN "1100010000" => u0_m0_wo0_cm0_q <= "00000000100001";
                WHEN "1100010001" => u0_m0_wo0_cm0_q <= "11111111011110";
                WHEN "1100010010" => u0_m0_wo0_cm0_q <= "11111110100111";
                WHEN "1100010011" => u0_m0_wo0_cm0_q <= "11111110000010";
                WHEN "1100010100" => u0_m0_wo0_cm0_q <= "11111101110010";
                WHEN "1100010101" => u0_m0_wo0_cm0_q <= "11111101110111";
                WHEN "1100010110" => u0_m0_wo0_cm0_q <= "11111110001110";
                WHEN "1100010111" => u0_m0_wo0_cm0_q <= "11111110110011";
                WHEN "1100011000" => u0_m0_wo0_cm0_q <= "11111111100000";
                WHEN "1100011001" => u0_m0_wo0_cm0_q <= "00000000001100";
                WHEN "1100011010" => u0_m0_wo0_cm0_q <= "00000000110100";
                WHEN "1100011011" => u0_m0_wo0_cm0_q <= "00000001010010";
                WHEN "1100011100" => u0_m0_wo0_cm0_q <= "00000001100010";
                WHEN "1100011101" => u0_m0_wo0_cm0_q <= "00000001100011";
                WHEN "1100011110" => u0_m0_wo0_cm0_q <= "00000001010110";
                WHEN "1100011111" => u0_m0_wo0_cm0_q <= "00000000111110";
                WHEN "1100100000" => u0_m0_wo0_cm0_q <= "00000000011111";
                WHEN "1100100001" => u0_m0_wo0_cm0_q <= "11111111111111";
                WHEN "1100100010" => u0_m0_wo0_cm0_q <= "11111111100000";
                WHEN "1100100011" => u0_m0_wo0_cm0_q <= "11111111000111";
                WHEN "1100100100" => u0_m0_wo0_cm0_q <= "11111110111000";
                WHEN "1100100101" => u0_m0_wo0_cm0_q <= "11111110110100";
                WHEN "1100100110" => u0_m0_wo0_cm0_q <= "11111110111011";
                WHEN "1100100111" => u0_m0_wo0_cm0_q <= "11111111001011";
                WHEN "1100101000" => u0_m0_wo0_cm0_q <= "11111111100010";
                WHEN "1100101001" => u0_m0_wo0_cm0_q <= "11111111111100";
                WHEN "1100101010" => u0_m0_wo0_cm0_q <= "00000000010100";
                WHEN "1100101011" => u0_m0_wo0_cm0_q <= "00000000101001";
                WHEN "1100101100" => u0_m0_wo0_cm0_q <= "00000000110111";
                WHEN "1100101101" => u0_m0_wo0_cm0_q <= "00000000111101";
                WHEN "1100101110" => u0_m0_wo0_cm0_q <= "00000000111010";
                WHEN "1100101111" => u0_m0_wo0_cm0_q <= "00000000101110";
                WHEN "1100110000" => u0_m0_wo0_cm0_q <= "00000000011101";
                WHEN "1100110001" => u0_m0_wo0_cm0_q <= "00000000001000";
                WHEN "1100110010" => u0_m0_wo0_cm0_q <= "11111111110100";
                WHEN "1100110011" => u0_m0_wo0_cm0_q <= "11111111100010";
                WHEN "1100110100" => u0_m0_wo0_cm0_q <= "11111111010101";
                WHEN "1100110101" => u0_m0_wo0_cm0_q <= "11111111001110";
                WHEN "1100110110" => u0_m0_wo0_cm0_q <= "11111111001111";
                WHEN "1100110111" => u0_m0_wo0_cm0_q <= "11111111010111";
                WHEN "1100111000" => u0_m0_wo0_cm0_q <= "11111111100100";
                WHEN "1100111001" => u0_m0_wo0_cm0_q <= "11111111110101";
                WHEN "1100111010" => u0_m0_wo0_cm0_q <= "00000000000110";
                WHEN "1100111011" => u0_m0_wo0_cm0_q <= "00000000010110";
                WHEN "1100111100" => u0_m0_wo0_cm0_q <= "00000000100010";
                WHEN "1100111101" => u0_m0_wo0_cm0_q <= "00000000101001";
                WHEN "1100111110" => u0_m0_wo0_cm0_q <= "00000000101010";
                WHEN "1100111111" => u0_m0_wo0_cm0_q <= "00000000100101";
                WHEN "1101000000" => u0_m0_wo0_cm0_q <= "00000000011011";
                WHEN "1101000001" => u0_m0_wo0_cm0_q <= "00000000001101";
                WHEN "1101000010" => u0_m0_wo0_cm0_q <= "11111111111111";
                WHEN "1101000011" => u0_m0_wo0_cm0_q <= "11111111110000";
                WHEN "1101000100" => u0_m0_wo0_cm0_q <= "11111111100101";
                WHEN "1101000101" => u0_m0_wo0_cm0_q <= "11111111011101";
                WHEN "1101000110" => u0_m0_wo0_cm0_q <= "11111111011011";
                WHEN "1101000111" => u0_m0_wo0_cm0_q <= "11111111011111";
                WHEN "1101001000" => u0_m0_wo0_cm0_q <= "11111111100111";
                WHEN "1101001001" => u0_m0_wo0_cm0_q <= "11111111110010";
                WHEN "1101001010" => u0_m0_wo0_cm0_q <= "11111111111111";
                WHEN "1101001011" => u0_m0_wo0_cm0_q <= "00000000001011";
                WHEN "1101001100" => u0_m0_wo0_cm0_q <= "00000000010110";
                WHEN "1101001101" => u0_m0_wo0_cm0_q <= "00000000011101";
                WHEN "1101001110" => u0_m0_wo0_cm0_q <= "00000000100000";
                WHEN "1101001111" => u0_m0_wo0_cm0_q <= "00000000011111";
                WHEN "1101010000" => u0_m0_wo0_cm0_q <= "00000000011000";
                WHEN "1101010001" => u0_m0_wo0_cm0_q <= "00000000001111";
                WHEN "1101010010" => u0_m0_wo0_cm0_q <= "00000000000100";
                WHEN "1101010011" => u0_m0_wo0_cm0_q <= "11111111111001";
                WHEN "1101010100" => u0_m0_wo0_cm0_q <= "11111111101111";
                WHEN "1101010101" => u0_m0_wo0_cm0_q <= "11111111100111";
                WHEN "1101010110" => u0_m0_wo0_cm0_q <= "11111111100011";
                WHEN "1101010111" => u0_m0_wo0_cm0_q <= "11111111100100";
                WHEN "1101011000" => u0_m0_wo0_cm0_q <= "11111111101000";
                WHEN "1101011001" => u0_m0_wo0_cm0_q <= "11111111110000";
                WHEN "1101011010" => u0_m0_wo0_cm0_q <= "11111111111010";
                WHEN "1101011011" => u0_m0_wo0_cm0_q <= "00000000000100";
                WHEN "1101011100" => u0_m0_wo0_cm0_q <= "00000000001110";
                WHEN "1101011101" => u0_m0_wo0_cm0_q <= "00000000010110";
                WHEN "1101011110" => u0_m0_wo0_cm0_q <= "00000000011010";
                WHEN "1101011111" => u0_m0_wo0_cm0_q <= "00000000011011";
                WHEN "1101100000" => u0_m0_wo0_cm0_q <= "00000000011000";
                WHEN "1101100001" => u0_m0_wo0_cm0_q <= "00000000010001";
                WHEN "1101100010" => u0_m0_wo0_cm0_q <= "00000000001000";
                WHEN "1101100011" => u0_m0_wo0_cm0_q <= "11111111111110";
                WHEN "1101100100" => u0_m0_wo0_cm0_q <= "11111111110100";
                WHEN "1101100101" => u0_m0_wo0_cm0_q <= "11111111101011";
                WHEN "1101100110" => u0_m0_wo0_cm0_q <= "11111111100110";
                WHEN "1101100111" => u0_m0_wo0_cm0_q <= "11111111100101";
                WHEN "1101101000" => u0_m0_wo0_cm0_q <= "11111111100111";
                WHEN "1101101001" => u0_m0_wo0_cm0_q <= "11111111101110";
                WHEN "1101101010" => u0_m0_wo0_cm0_q <= "11111111110111";
                WHEN "1101101011" => u0_m0_wo0_cm0_q <= "00000000000001";
                WHEN "1101101100" => u0_m0_wo0_cm0_q <= "00000000001100";
                WHEN "1101101101" => u0_m0_wo0_cm0_q <= "00000000010110";
                WHEN "1101101110" => u0_m0_wo0_cm0_q <= "00000000011100";
                WHEN "1101101111" => u0_m0_wo0_cm0_q <= "00000000011110";
                WHEN "1101110000" => u0_m0_wo0_cm0_q <= "00000000011011";
                WHEN "1101110001" => u0_m0_wo0_cm0_q <= "00000000010100";
                WHEN "1101110010" => u0_m0_wo0_cm0_q <= "00000000001001";
                WHEN "1101110011" => u0_m0_wo0_cm0_q <= "11111111111101";
                WHEN "1101110100" => u0_m0_wo0_cm0_q <= "11111111110000";
                WHEN "1101110101" => u0_m0_wo0_cm0_q <= "11111111100100";
                WHEN "1101110110" => u0_m0_wo0_cm0_q <= "11111111011101";
                WHEN "1101110111" => u0_m0_wo0_cm0_q <= "11111111011011";
                WHEN "1101111000" => u0_m0_wo0_cm0_q <= "11111111100000";
                WHEN "1101111001" => u0_m0_wo0_cm0_q <= "11111111101011";
                WHEN "1101111010" => u0_m0_wo0_cm0_q <= "11111111111100";
                WHEN "1101111011" => u0_m0_wo0_cm0_q <= "00000000001111";
                WHEN "1101111100" => u0_m0_wo0_cm0_q <= "00000000100010";
                WHEN "1101111101" => u0_m0_wo0_cm0_q <= "00000000110001";
                WHEN "1101111110" => u0_m0_wo0_cm0_q <= "00000000110111";
                WHEN "1101111111" => u0_m0_wo0_cm0_q <= "00000000110001";
                WHEN "1110000000" => u0_m0_wo0_cm0_q <= "00000000011101";
                WHEN "1110000001" => u0_m0_wo0_cm0_q <= "11111111111111";
                WHEN "1110000010" => u0_m0_wo0_cm0_q <= "11111111011000";
                WHEN "1110000011" => u0_m0_wo0_cm0_q <= "11111110110010";
                WHEN "1110000100" => u0_m0_wo0_cm0_q <= "11111110011011";
                WHEN "1110000101" => u0_m0_wo0_cm0_q <= "11111110100011";
                WHEN "1110000110" => u0_m0_wo0_cm0_q <= "11111111011101";
                WHEN "1110000111" => u0_m0_wo0_cm0_q <= "00000001010010";
                WHEN "1110001000" => u0_m0_wo0_cm0_q <= "00000011101001";
                WHEN "1110001001" => u0_m0_wo0_cm0_q <= "00000100000001";
                WHEN "1110001010" => u0_m0_wo0_cm0_q <= "11111000101100";
                WHEN "1110001011" => u0_m0_wo0_cm0_q <= "00000001101011";
                WHEN OTHERS => u0_m0_wo0_cm0_q <= (others => '-');
            END CASE;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_mtree_mult1_0(MULT,35)@16
    u0_m0_wo0_mtree_mult1_0_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm0_q);
    u0_m0_wo0_mtree_mult1_0_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_sym_add0_q);
    u0_m0_wo0_mtree_mult1_0_reset <= areset;
    u0_m0_wo0_mtree_mult1_0_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 14,
        lpm_widthb => 13,
        lpm_widthp => 27,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 1
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_0_a0,
        datab => u0_m0_wo0_mtree_mult1_0_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_0_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_0_s1
    );
    u0_m0_wo0_mtree_mult1_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_0_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_0_q <= u0_m0_wo0_mtree_mult1_0_s1;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_accum(ADD,37)@18
    u0_m0_wo0_accum_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 27 => u0_m0_wo0_mtree_mult1_0_q(26)) & u0_m0_wo0_mtree_mult1_0_q));
    u0_m0_wo0_accum_b <= STD_LOGIC_VECTOR(u0_m0_wo0_accum_q);
    u0_m0_wo0_accum_i <= u0_m0_wo0_accum_a;
    u0_m0_wo0_accum: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_accum_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_18_q = "1") THEN
                IF (u0_m0_wo0_aseq_q = "1") THEN
                    u0_m0_wo0_accum_o <= u0_m0_wo0_accum_i;
                ELSE
                    u0_m0_wo0_accum_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_accum_a) + SIGNED(u0_m0_wo0_accum_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_accum_q <= u0_m0_wo0_accum_o(34 downto 0);

    -- GND(CONSTANT,0)@0
    GND_q <= "0";

    -- u0_m0_wo0_oseq(SEQUENCE,38)@17
    u0_m0_wo0_oseq: PROCESS (clk, areset)
        variable u0_m0_wo0_oseq_c : SIGNED(9 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_oseq_c := "0010001011";
            u0_m0_wo0_oseq_q <= "0";
            u0_m0_wo0_oseq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_17_q = "1") THEN
                IF (u0_m0_wo0_oseq_c = "0000000000") THEN
                    u0_m0_wo0_oseq_eq <= '1';
                ELSE
                    u0_m0_wo0_oseq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_oseq_eq = '1') THEN
                    u0_m0_wo0_oseq_c := u0_m0_wo0_oseq_c + 139;
                ELSE
                    u0_m0_wo0_oseq_c := u0_m0_wo0_oseq_c - 1;
                END IF;
                u0_m0_wo0_oseq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_oseq_c(9 downto 9));
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_oseq_gated(LOGICAL,39)@18
    u0_m0_wo0_oseq_gated_a <= u0_m0_wo0_oseq_q;
    u0_m0_wo0_oseq_gated_b <= d_u0_m0_wo0_compute_q_18_q;
    u0_m0_wo0_oseq_gated_q <= u0_m0_wo0_oseq_gated_a and u0_m0_wo0_oseq_gated_b;

    -- u0_m0_wo0_oseq_gated_reg(REG,40)@18
    u0_m0_wo0_oseq_gated_reg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= STD_LOGIC_VECTOR(u0_m0_wo0_oseq_gated_q);
        END IF;
    END PROCESS;

    -- xOut(PORTOUT,43)@19
    xOut_v <= u0_m0_wo0_oseq_gated_reg_q;
    xOut_c <= STD_LOGIC_VECTOR("0000000" & GND_q);
    xOut_0 <= u0_m0_wo0_accum_q;

END normal;
