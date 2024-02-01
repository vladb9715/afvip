// -----------------------------------------------------------------------------
// Module name: afvip_apb_pkg
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Keep all of the APB components in an organized fashion.
// Date       : 25 July, 2023
// -----------------------------------------------------------------------------
package afvip_apb_pkg;
    import uvm_pkg::*;
    
    `include "uvm_macros.svh"
    `include "afvip_apb_item.svh"
    `include "afvip_apb_sequencer.svh"
    `include "afvip_apb_driver.svh"
    `include "afvip_apb_monitor.svh"
    `include "afvip_apb_agent.svh"
    `include "afvip_apb_sequence.svh"
    `include "afvip_coverage.svh"
endpackage : afvip_apb_pkg