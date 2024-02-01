// -----------------------------------------------------------------------------
// Module name: afvip_apb_agent
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Active reset agent that instantiates all three components.
// Date       : 25 July, 2023
// -----------------------------------------------------------------------------
class afvip_rst_agent extends uvm_agent;
    `uvm_component_utils (afvip_rst_agent)
    // Constructor
    function new (string name = "afvip_rst_agent", uvm_component parent = null);
        super.new (name, parent);
    endfunction : new
    // Handles for the encapsulated driver, monitor and sequencer.
    afvip_rst_driver          i_afvip_rst_driver    ;
    afvip_rst_monitor         i_afvip_rst_monitor   ;
    afvip_rst_sequencer       i_afvip_rst_sequencer ;

    virtual function void build_phase (uvm_phase phase);
        if (get_is_active()) begin
            i_afvip_rst_sequencer = afvip_rst_sequencer :: type_id :: create ("i_afvip_rst_sequencer", this);
            i_afvip_rst_driver    = afvip_rst_driver    :: type_id :: create ("i_afvip_rst_driver"   , this);
                `uvm_info (get_name (), "This is the active reset agent.", UVM_MEDIUM);
        end
        i_afvip_rst_monitor = afvip_rst_monitor :: type_id :: create ("i_afvip_rst_monitor", this);
    endfunction

    virtual function void connect_phase (uvm_phase phase);
        if (get_is_active())
            i_afvip_rst_driver.seq_item_port.connect (i_afvip_rst_sequencer.seq_item_export);
    endfunction

endclass : afvip_rst_agent