// -----------------------------------------------------------------------------------------
// Module name: afvip_intr_item
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Base class for the interrupt sequence item.
// Date       : 25 July, 2023
// -----------------------------------------------------------------------------------------
class afvip_intr_item extends uvm_sequence_item;
    // Interrupt item
    rand bit    item_afvip_intr;
    // Utility and Field macro
    `uvm_object_utils_begin (afvip_intr_item)
        `uvm_field_int (item_afvip_intr , UVM_DEFAULT)
    `uvm_object_utils_end
    // Constructor
    function new (string name = "");
        super.new (name);
    endfunction : new
endclass : afvip_intr_item