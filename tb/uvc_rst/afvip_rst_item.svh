// -----------------------------------------------------------------------------------------
// Module name: afvip_rst_item
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Base class for the reset sequence item.
// Date       : 25 July, 2023
// -----------------------------------------------------------------------------------------
class afvip_rst_item extends uvm_sequence_item;
    // Asynchronous reset active low
    rand bit    rst_n;
    // Utility and Field macro
    `uvm_object_utils_begin (afvip_rst_item)
        `uvm_field_int (rst_n , UVM_DEFAULT)
    `uvm_object_utils_end
    // Constructor
    function new (string name = "");
        super.new (name);
    endfunction : new
endclass :  afvip_rst_item