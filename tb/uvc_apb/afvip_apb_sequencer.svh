// -----------------------------------------------------------------------------------------
// Module name: afvip_apb_sequencer
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Generates data transactions and sends them to the APB driver for execution.
// Date       : 25 July, 2023
// -----------------------------------------------------------------------------------------
class afvip_apb_sequencer extends uvm_sequencer #(afvip_apb_item);
    `uvm_component_utils (afvip_apb_sequencer)
    // Constructor
    function new (string name = "afvip_apb_sequencer", uvm_component parent);
        super.new (name, parent);
    endfunction : new
endclass : afvip_apb_sequencer