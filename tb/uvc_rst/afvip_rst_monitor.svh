// -----------------------------------------------------------------------------
// Module name: afvip_rst_monitor
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Monitor responsible for capturing the reset signal activity.
// Date       : 25 July, 2023
// -----------------------------------------------------------------------------
class afvip_rst_monitor extends uvm_monitor;
    `uvm_component_utils (afvip_rst_monitor)
    // Constructor
    function new (string name = "afvip_rst_monitor", uvm_component parent = null);
        super.new (name, parent);
    endfunction : new
    // Virtual system interface handle
    virtual afvip_sys_if vif_afvip_sys_interface;
    // Declaration of the analysis port
    uvm_analysis_port #(afvip_rst_item) rst_mon_analysis_port;

    virtual function void build_phase (uvm_phase phase);
        super.build_phase (phase);
        // Create an instance of the declared analysis port
        rst_mon_analysis_port = new ("rst_mon_analysis_port", this);
        // Get virtual interface handle from the configuration database
        if (! uvm_config_db #(virtual afvip_sys_if) :: get (this, "", "afvip_sys_interface", vif_afvip_sys_interface)) begin
            `uvm_fatal (get_type_name (), "The reset monitor did not find the system interface.")
        end

    endfunction : build_phase

    virtual task run_phase (uvm_phase phase);
        
        afvip_rst_item vit_afvip_rst_item = afvip_rst_item :: type_id :: create ("vit_afvip_rst_item", this);

            @ (negedge vif_afvip_sys_interface.cb_sys_rst_mon.rst_n);
            vit_afvip_rst_item.rst_n = vif_afvip_sys_interface.cb_sys_rst_mon.rst_n;
            rst_mon_analysis_port.write (vit_afvip_rst_item);
                `uvm_info ("Reset Monitor", $sformatf ("Saw item: %s", vit_afvip_rst_item.sprint()), UVM_NONE)

    endtask : run_phase

endclass : afvip_rst_monitor