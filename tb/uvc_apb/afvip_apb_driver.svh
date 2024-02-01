// -----------------------------------------------------------------------------
// Module name: afvip_apb_driver
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Typical AMBA APB Protocol write and read transfers reproduction.
// Date       : 25 July, 2023
// -----------------------------------------------------------------------------
class afvip_apb_driver extends uvm_driver #(afvip_apb_item);
    `uvm_component_utils (afvip_apb_driver)
    // Constructor
    function new (string name = "afvip_apb_driver", uvm_component parent = null);
        super.new (name, parent);
    endfunction : new
    // APB virtual interface handle
    virtual afvip_apb_if vif_afvip_apb_interface;

    virtual function void build_phase (uvm_phase phase);
        super.build_phase (phase);
        // Get virtual APB interface handle from the configuration database
        if (! uvm_config_db #(virtual afvip_apb_if) :: get (this, "", "afvip_apb_interface", vif_afvip_apb_interface)) begin
            `uvm_fatal (get_type_name (), "Didn't get handle to virtual interface 'vif_afvip_apb_interface'.")
        end
    endfunction : build_phase
    
    virtual task run_phase (uvm_phase phase);
        afvip_apb_item vit_afvip_apb_item;

        @ (posedge vif_afvip_apb_interface.rst_n);

        forever begin
            seq_item_port.get_next_item (vit_afvip_apb_item);
            `uvm_info ("APB Driver", $sformatf ("Saw item: %s", vit_afvip_apb_item.sprint()), UVM_MEDIUM)

            vif_afvip_apb_interface.cb_apb_drv.psel   <= 1;

            vif_afvip_apb_interface.cb_apb_drv.paddr  <= vit_afvip_apb_item.paddr   ;
            vif_afvip_apb_interface.cb_apb_drv.pwdata <= vit_afvip_apb_item.pwdata  ;
            vif_afvip_apb_interface.cb_apb_drv.pwrite <= vit_afvip_apb_item.pwrite  ;

            @ (vif_afvip_apb_interface.cb_apb_drv iff vif_afvip_apb_interface.cb_apb_mon.psel);
            vif_afvip_apb_interface.cb_apb_drv.penable <= 1;

            @ (vif_afvip_apb_interface.cb_apb_drv iff vif_afvip_apb_interface.cb_apb_drv.pready);
            vif_afvip_apb_interface.cb_apb_drv.penable <= 0;
            vif_afvip_apb_interface.cb_apb_drv.psel    <= 0;
            
            @ (vif_afvip_apb_interface.cb_apb_drv);
            
            seq_item_port.item_done ();
        end
    endtask : run_phase

endclass : afvip_apb_driver