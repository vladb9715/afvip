// -----------------------------------------------------------------------------
// Module name: afvip_test_pkg
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Keep all of the sequences and tests in an organized fashion.
// Date       : 25 July, 2023
// -----------------------------------------------------------------------------
package afvip_test_pkg;
    import uvm_pkg::*;
    import afvip_apb_pkg::*;
    import afvip_intr_pkg::*;
    import afvip_rst_pkg::*;

    `include "uvm_macros.svh"
    `include "afvip_vsequencer.svh"
    `include "afvip_vsequence_lib.svh"
    `include "afvip_scoreboard.svh"
    `include "afvip_environment.svh"
    `include "afvip_test_lib.svh"
endpackage : afvip_test_pkg