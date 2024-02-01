// -----------------------------------------------------------------------------
// Module name: afvip_intr_agent
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Passive APB agent that only instantiates the monitor.
// Date       : 25 July, 2023
// -----------------------------------------------------------------------------
class afvip_intr_agent extends uvm_agent;
    `uvm_component_utils (afvip_intr_agent)
    // Constructor
    function new (string name = "afvip_intr_agent", uvm_component parent = null);
        super.new (name, parent);
    endfunction : new
    // Interrupt monitor handle
    afvip_intr_monitor  i_afvip_intr_monitor;
    // Creating required monitor (regardless of agent's nature)
    virtual function void build_phase (uvm_phase phase);
        if(!get_is_active()) begin
            i_afvip_intr_monitor = afvip_intr_monitor :: type_id :: create ("i_afvip_intr_monitor", this);
                `uvm_info (get_name (), "This is the passive interrupt agent.", UVM_MEDIUM);
        end
    endfunction
    // Mandatory connect phase placeholder
    virtual function void connect_phase (uvm_phase phase);
        //
    endfunction
endclass : afvip_intr_agent