// -----------------------------------------------------------------------------
// Module name: afvip_apb_item
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Base class for the APB sequence items and factory register.
// Date       : 25 July, 2023
// -----------------------------------------------------------------------------
class afvip_apb_item extends uvm_sequence_item;
    // Sequencer signals
    rand bit        psel    ;   // Select.         PSELx indicates that the Completer is selected and that a data transfer is required.
    rand bit        penable ;   // Enable.         PENABLE indicates the second and subsequent cycles of an APB transfer.
    rand bit [15:0] paddr   ;   // Address.        PADDR is the APB address bus.
    rand bit        pwrite  ;   // Direction.      PWRITE indicates an APB write access when HIGH and an APB read access when LOW.
    rand bit [31:0] prdata  ;   // Read data.      The PRDATA read data bus is driven by the selected Completer during read cycles when PWRITE is LOW.
    rand bit [31:0] pwdata  ;   // Write data.     The PWDATA write data bus is driven by the APB bridge Requester during write cycles when PWRITE is HIGH. 
    // Instruction format signals
    rand logic  [ 2:0] opcode   ;   // Operation code. Logic type used in coverage as default value is X.
    rand bit    [ 4:0] dst      ;   // Destination register address.
    rand bit    [ 4:0] rs0      ;   // Source register 0.
    rand bit    [ 4:0] rs1      ;   // Source register 1.
    rand bit    [ 7:0] imm      ;   // Immediate value.
    // Test number used in scoreboard and top module
    logic       [ 3:0] testnr   ;   // Test number. Used to select which test to run and display scoreboard accordingly.
    // Scoreboard reset
    logic              apb_rst  ;   // Copy reset value from the rst_n for the scoreboard checker.
    // Utility and Field macros
    `uvm_object_utils_begin (afvip_apb_item)
        `uvm_field_int (psel    , UVM_DEFAULT)
        `uvm_field_int (penable , UVM_DEFAULT)
        `uvm_field_int (paddr   , UVM_DEFAULT)
        `uvm_field_int (pwrite  , UVM_DEFAULT)
        `uvm_field_int (pwdata  , UVM_DEFAULT)
        `uvm_field_int (prdata  , UVM_DEFAULT)
        `uvm_field_int (opcode  , UVM_DEFAULT)
        `uvm_field_int (dst     , UVM_DEFAULT)
        `uvm_field_int (rs0     , UVM_DEFAULT)
        `uvm_field_int (rs1     , UVM_DEFAULT)
        `uvm_field_int (imm     , UVM_DEFAULT)
        `uvm_field_int (testnr  , UVM_DEFAULT)
        `uvm_field_int (apb_rst , UVM_DEFAULT)
    `uvm_object_utils_end
    // Constructor
    function new (string name = "");
        super.new(name);
    endfunction : new
endclass : afvip_apb_item