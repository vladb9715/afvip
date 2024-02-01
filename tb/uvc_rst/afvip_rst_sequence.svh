// -----------------------------------------------------------------------------
// Module name: afvip_rst_sequence
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Asynchronous reset active low sequence.
// Date       : 25 July, 2023
// -----------------------------------------------------------------------------
class afvip_rst_base_sequence extends uvm_sequence;
    `uvm_object_utils (afvip_rst_base_sequence)
    // Constructor
    function new (string name = "afvip_rst_base_sequence");
        super.new (name);
    endfunction : new

    virtual task body ();
        //
    endtask : body
endclass : afvip_rst_base_sequence
// Start sequence
class afvip_rst_sequence extends afvip_rst_base_sequence;
    `uvm_object_utils (afvip_rst_sequence)
    // Constructor
    function new (string name = "afvip_rst_sequence");
        super.new (name);
    endfunction : new

    virtual task body ();
        afvip_rst_item vit_afvip_rst_item;

        vit_afvip_rst_item = afvip_rst_item :: type_id :: create ("vit_afvip_rst_item");

        start_item (vit_afvip_rst_item);
            vit_afvip_rst_item.rst_n = 0;
        finish_item (vit_afvip_rst_item);

        #20ns;

        start_item (vit_afvip_rst_item);
            vit_afvip_rst_item.rst_n = 1;
        finish_item (vit_afvip_rst_item);

    endtask : body
endclass : afvip_rst_sequence
// Reset sequence
class afvip_rst_sequence_fork extends afvip_rst_base_sequence;
    `uvm_object_utils (afvip_rst_sequence_fork)
    // Constructor
    function new (string name = "afvip_rst_sequence_fork");
        super.new (name);
    endfunction : new

    virtual task body ();
        afvip_rst_item vit_afvip_rst_item;

        vit_afvip_rst_item = afvip_rst_item :: type_id :: create ("vit_afvip_rst_item");

        #160ns;

        start_item (vit_afvip_rst_item);
            vit_afvip_rst_item.rst_n = 0;
        finish_item (vit_afvip_rst_item);

        #200ns;

        start_item (vit_afvip_rst_item);
            vit_afvip_rst_item.rst_n = 1;
        finish_item (vit_afvip_rst_item);

    endtask : body
endclass : afvip_rst_sequence_fork