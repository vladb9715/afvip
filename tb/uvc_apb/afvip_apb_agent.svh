// -----------------------------------------------------------------------------
// Module name: afvip_apb_agent
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Active APB agent that instantiates all three components.
// Date       : 25 July, 2023
// -----------------------------------------------------------------------------
class afvip_apb_agent extends uvm_agent;
    `uvm_component_utils (afvip_apb_agent)
    // Constructor
    function new (string name = "afvip_apb_agent", uvm_component parent = null);
        super.new (name, parent);
    endfunction : new
    // Handles for the encapsulated driver, monitor and sequencer.
    afvip_apb_driver          i_afvip_apb_driver    ;
    afvip_apb_monitor         i_afvip_apb_monitor   ;
    afvip_apb_sequencer       i_afvip_apb_sequencer ;
    // Creating required sequencer, driver and monitor for the active APB agent
    virtual function void build_phase (uvm_phase phase);
        if (get_is_active()) begin
            i_afvip_apb_sequencer = afvip_apb_sequencer :: type_id :: create ("i_afvip_apb_sequencer", this);
            i_afvip_apb_driver    = afvip_apb_driver    :: type_id :: create ("i_afvip_apb_driver"   , this);
                `uvm_info (get_name (), "This is the active APB agent.", UVM_MEDIUM);
            end
            i_afvip_apb_monitor   = afvip_apb_monitor   :: type_id :: create ("i_afvip_apb_monitor"  , this);
    endfunction

    virtual function void connect_phase (uvm_phase phase);
        if (get_is_active())
            i_afvip_apb_driver.seq_item_port.connect (i_afvip_apb_sequencer.seq_item_export);
    endfunction

endclass : afvip_apb_agent