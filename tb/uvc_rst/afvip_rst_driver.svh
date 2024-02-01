// -----------------------------------------------------------------------------
// Module name: afvip_rst_driver
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Active reset driver.
// Date       : 25 July, 2023
// -----------------------------------------------------------------------------
class afvip_rst_driver extends uvm_driver #(afvip_rst_item);
    `uvm_component_utils (afvip_rst_driver)
    // Constructor
    function new (string name = "afvip_rst_driver", uvm_component parent = null);
        super.new (name, parent);
    endfunction : new
    // Virtual system interface handle
    virtual afvip_sys_if vif_afvip_sys_interface;

    virtual function void build_phase (uvm_phase phase);
        super.build_phase (phase);
        // Get virtual system interface handle from the configuration database
        if (! uvm_config_db #(virtual afvip_sys_if) :: get (this, "", "afvip_sys_interface", vif_afvip_sys_interface)) begin
            `uvm_fatal (get_type_name (), "Didn't get handle to virtual interface 'vif_afvip_sys_interface'.")
        end
    endfunction : build_phase

    virtual task run_phase (uvm_phase phase);
        afvip_rst_item vit_afvip_rst_item;

        forever begin
            `uvm_info (get_type_name (), $sformatf ("Waiting for data from 'afvip_rst_sequencer'."), UVM_MEDIUM)
            seq_item_port.get_next_item (vit_afvip_rst_item);
            $display("%s", vit_afvip_rst_item.sprint());

            vif_afvip_sys_interface.rst_n <= vit_afvip_rst_item.rst_n;

            seq_item_port.item_done ();
        end

    endtask : run_phase
endclass : afvip_rst_driver