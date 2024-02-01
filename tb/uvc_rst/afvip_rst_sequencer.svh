// ------------------------------------------------------------------------------------------
// Module name: afvip_rst_sequencer
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Generates data transactions and sends them to the reset driver for execution.
// Date       : 25 July, 2023
// ------------------------------------------------------------------------------------------
class afvip_rst_sequencer extends uvm_sequencer #(afvip_rst_item);
    `uvm_component_utils (afvip_rst_sequencer)
    // Constructor
    function new (string name = "afvip_rst_sequencer", uvm_component parent);
        super.new (name, parent);
    endfunction : new
endclass : afvip_rst_sequencer