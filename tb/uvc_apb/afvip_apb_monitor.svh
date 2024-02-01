// -----------------------------------------------------------------------------
// Module name: afvip_apb_monitor
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Monitor responsible for capturing signal activity from DUT.
// Date       : 25 July, 2023
// -----------------------------------------------------------------------------
class afvip_apb_monitor extends uvm_monitor;
    `uvm_component_utils (afvip_apb_monitor)
    // Constructor
    function new (string name = "afvip_apb_monitor", uvm_component parent = null);
        super.new (name, parent);
    endfunction : new
    // APB virtual interface handle
    virtual afvip_apb_if vif_afvip_apb_interface;
    // Declaration of the analysis port
    uvm_analysis_port #(afvip_apb_item) apb_mon_analysis_port;

    virtual function void build_phase (uvm_phase phase);
        super.build_phase (phase);
        // Create an instance of the declared analysis port
        apb_mon_analysis_port = new ("apb_mon_analysis_port", this);
        // Get virtual interface handle from the configuration database
        if (! uvm_config_db #(virtual afvip_apb_if) :: get (this, "", "afvip_apb_interface", vif_afvip_apb_interface)) begin
            `uvm_fatal (get_type_name (), "The APB monitor did not find the APB interface.")
        end

    endfunction : build_phase

    virtual task run_phase (uvm_phase phase);
        
        afvip_apb_item vit_afvip_apb_item = afvip_apb_item :: type_id :: create ("vit_afvip_apb_item", this);

       forever begin
            // Reset value
            vit_afvip_apb_item.apb_rst = vif_afvip_apb_interface.rst_n;
            // APB protocol format
            @   (vif_afvip_apb_interface.cb_apb_mon iff (   vif_afvip_apb_interface.cb_apb_mon.psel    &&
                                                            vif_afvip_apb_interface.cb_apb_mon.penable &&
                                                            vif_afvip_apb_interface.cb_apb_mon.pready
                                                        )
                );
            
            vit_afvip_apb_item.psel     = vif_afvip_apb_interface.cb_apb_mon.psel   ;
            vit_afvip_apb_item.penable  = vif_afvip_apb_interface.cb_apb_mon.penable;
            vit_afvip_apb_item.paddr    = vif_afvip_apb_interface.cb_apb_mon.paddr  ;
            vit_afvip_apb_item.pwrite   = vif_afvip_apb_interface.cb_apb_mon.pwrite ;

            vit_afvip_apb_item.testnr   = vif_afvip_apb_interface.cb_apb_mon.testnr ;

            if (vif_afvip_apb_interface.cb_apb_mon.pwrite)
                vit_afvip_apb_item.pwdata = vif_afvip_apb_interface.cb_apb_mon.pwdata;
            else
                vit_afvip_apb_item.prdata = vif_afvip_apb_interface.cb_apb_mon.prdata;

            // Configuration instruction format
            if (vif_afvip_apb_interface.cb_apb_mon.paddr == 16'h80) begin
                vit_afvip_apb_item.opcode = vif_afvip_apb_interface.cb_apb_mon.pwdata [2:0]  ;
                vit_afvip_apb_item.rs0    = vif_afvip_apb_interface.cb_apb_mon.pwdata [7:3]  ;
                vit_afvip_apb_item.rs1    = vif_afvip_apb_interface.cb_apb_mon.pwdata [12:8] ;
                vit_afvip_apb_item.dst    = vif_afvip_apb_interface.cb_apb_mon.pwdata [20:16];
                vit_afvip_apb_item.imm    = vif_afvip_apb_interface.cb_apb_mon.pwdata [31:24];
            end
            apb_mon_analysis_port.write (vit_afvip_apb_item);
            `uvm_info("APB Monitor", $sformatf ("Saw item: %s", vit_afvip_apb_item.sprint()), UVM_NONE)

        end

    endtask : run_phase

endclass : afvip_apb_monitor