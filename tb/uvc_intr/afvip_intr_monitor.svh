// -----------------------------------------------------------------------------
// Module name: afvip_apb_monitor
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Monitor responsible for capturing the interrupt signal activity.
// Date       : 25 July, 2023
// -----------------------------------------------------------------------------
class afvip_intr_monitor extends uvm_monitor;
    `uvm_component_utils (afvip_intr_monitor)
    // Constructor
    function new (string name = "afvip_intr_monitor", uvm_component parent = null);
        super.new (name, parent);
    endfunction : new
    // Virtual system interface handle
    virtual afvip_sys_if vif_afvip_sys_interface;
    // Declaration of the analysis port
    uvm_analysis_port #(afvip_intr_item) intr_mon_analysis_port;

    virtual function void build_phase (uvm_phase phase);
        super.build_phase (phase);
        // Create an instance of the declared analysis port
        intr_mon_analysis_port = new ("intr_mon_analysis_port", this);
        // Get virtual interface handle from the configuration database
        if (! uvm_config_db #(virtual afvip_sys_if) :: get (this, "", "afvip_sys_interface", vif_afvip_sys_interface)) begin
            `uvm_fatal (get_type_name (), "The interrupt monitor did not find the system interface.")
        end

    endfunction : build_phase

    virtual task run_phase (uvm_phase phase);
        
        afvip_intr_item vit_afvip_intr_item = afvip_intr_item :: type_id :: create ("vit_afvip_intr_item", this);

        forever begin
            @(posedge vif_afvip_sys_interface.cb_sys_intr_mon.afvip_intr);
            vit_afvip_intr_item.item_afvip_intr = vif_afvip_sys_interface.cb_sys_intr_mon.afvip_intr;

            intr_mon_analysis_port.write (vit_afvip_intr_item);
            `uvm_info ("Interrupt Monitor", $sformatf ("Saw item: %s", vit_afvip_intr_item.sprint()), UVM_NONE)
        end

    endtask : run_phase

endclass : afvip_intr_monitor