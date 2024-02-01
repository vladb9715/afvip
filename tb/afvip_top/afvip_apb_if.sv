interface afvip_apb_if (
    input clk   ,
    input rst_n
);

import uvm_pkg::*;
    `include "uvm_macros.svh"

wire        psel    ;
wire        penable ;
wire [15:0] paddr   ;
wire        pwrite  ;
wire [31:0] pwdata  ;
wire        pready  ;
wire [31:0] prdata  ;
wire        pslverr ;

wire [ 3:0] testnr  ;
wire        apb_rst ;

clocking cb_apb_drv @ (posedge i_afvip_sys_interface.clk);
    output  psel   ;
    output  penable;
    output  paddr  ;
    output  pwrite ;
    output  pwdata ;
    input   pready ;
    input   prdata ;
    input   pslverr;
endclocking

clocking cb_apb_mon @ (posedge i_afvip_sys_interface.clk);
    input   psel   ;
    input   penable;
    input   paddr  ;
    input   pwrite ;
    input   pwdata ;
    input   pready ;
    input   prdata ;
    input   pslverr;
    input   testnr ;
    input   apb_rst;
endclocking

// Assertions--------------------------------------------------------------------------
// Check if PENABLE is asserted after PSEL is high and one clock cycle passed.
property assert_penable;
    @ (clk) disable iff (!psel)
        (psel & penable) |-> $rose (clk);
endproperty : assert_penable

assert property (assert_penable)    `uvm_info ("Assertion <assert_penable>", $sformatf ("PENABLE is high after PSEL is high and one clock cycle passed."), UVM_NONE)
else                                `uvm_error("Assertion <assert_penable>", $sformatf ("PENABLE is not high after PSEL is high and one clock cycle passed."))
// Confirm PWDATA is stable during a write transfer.
property stable_pwdata;
    @ (posedge clk) disable iff (!rst_n)
        (psel & pwrite & penable) |-> ($stable (pwdata) and ##[1: $] $fell (penable));
endproperty : stable_pwdata

assert property (stable_pwdata)     `uvm_info ("Assertion <stable_pwdata>", $sformatf ("PWDATA is stable."), UVM_NONE)
else                                `uvm_error("Assertion <stable_pwdata>", $sformatf ("PWDATA is not stable."))
// Confirm PADDR is stable during a write or read transfer.
property stable_paddr;
    @ (posedge clk) disable iff (!rst_n)
        (psel & penable) |-> ($stable (paddr) and ##[1: $] $fell (penable));
endproperty : stable_paddr

assert property (stable_paddr)      `uvm_info ("Assertion <stable_paddr>", $sformatf ("PADDR is stable."), UVM_NONE)
else                                `uvm_error("Assertion <stable_paddr>", $sformatf ("PADDR is not stable."))
// Check if PENABLE is deasserted when PSEL is deasserted.
property psel_penable;
    @ (posedge clk) disable iff (!rst_n)
        $fell (psel) |-> ($past (penable) == 1 && penable == 0);
endproperty : psel_penable

assert property (psel_penable)      `uvm_info ("Assertion <psel_penable>", $sformatf ("PENABLE is deasserted when PSEL is deasserted."), UVM_NONE)
else                                `uvm_error("Assertion <psel_penable>", $sformatf ("PENABLE is not deasserted when PSEL is deasserted."))
// Confirm PSEL is asserted two clock cycles.
property psel_time;
    @ (posedge clk) disable iff (!rst_n)
        $rose (psel) |-> not (##1 $fell (psel));
endproperty : psel_time

assert property (psel_time)         `uvm_info ("Assertion <psel_time>", $sformatf ("PSEL is high for two clock cycles."), UVM_NONE)
else                                `uvm_error("Assertion <psel_time>", $sformatf ("PSEL is not high for two clock cycles."))
// Check if the read transfer is done successfully.
property read_transfer;
    @ (clk) disable iff (!rst_n)
        (psel & !pwrite & penable & pready & !pslverr & $changed (prdata)) |-> $rose (clk);
endproperty : read_transfer

assert property (read_transfer)     `uvm_info ("Assertion <read_transfer>", $sformatf ("Read successfully."), UVM_NONE)
else                                `uvm_error("Assertion <read_transfer>", $sformatf ("Read error."))

endinterface : afvip_apb_if