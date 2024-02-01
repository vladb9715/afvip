// -----------------------------------------------------------------------------
// Module name: afvip_apb_pkg
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Keep all of the interrupt components in an organized fashion.
// Date       : 25 July, 2023
// -----------------------------------------------------------------------------
package afvip_intr_pkg;
    import uvm_pkg::*;
    
    `include "uvm_macros.svh"
    `include "afvip_intr_item.svh"
    `include "afvip_intr_monitor.svh"
    `include "afvip_intr_agent.svh"
endpackage : afvip_intr_pkg