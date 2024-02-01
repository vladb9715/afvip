// -----------------------------------------------------------------------------
// Module name: afvip_vsequencer
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Virtual sequencer that contains handles to the other sequences.
// Date       : 25 July, 2023
// -----------------------------------------------------------------------------
class afvip_vsequencer extends uvm_sequencer;
  `uvm_component_utils (afvip_vsequencer)
  // APB sequencer handle
  afvip_apb_sequencer   vir_afvip_apb_sequencer;
  // Constructor
  function new (string name, uvm_component parent);
    super.new (name, parent);
  endfunction : new
  
  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
  endfunction : build_phase
  
endclass : afvip_vsequencer