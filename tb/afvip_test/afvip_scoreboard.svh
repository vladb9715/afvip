// ----------------------------------------------------------------------------------------
// Module name: afvip_scoreboard
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Contains checkers to confirm that the functional test behaves as expected.
// Date       : 25 July, 2023
// ----------------------------------------------------------------------------------------

// TLM implementation declaration macros for multiple write functions
`uvm_analysis_imp_decl (_apb)
`uvm_analysis_imp_decl (_intr)
`uvm_analysis_imp_decl (_rst)

class afvip_scoreboard extends uvm_scoreboard;
    `uvm_component_utils (afvip_scoreboard)
    // Constructor
    function new (string name = "afvip_scoreboard", uvm_component parent = null);
        super.new (name, parent);
    endfunction : new
    // Receivers with macros for all broadcasted transactions
    uvm_analysis_imp_apb    #(afvip_apb_item    , afvip_scoreboard) afvip_apb_item_scoreboard   ;
    uvm_analysis_imp_intr   #(afvip_intr_item   , afvip_scoreboard) afvip_intr_item_scoreboard  ;
    uvm_analysis_imp_rst    #(afvip_rst_item    , afvip_scoreboard) afvip_rst_item_scoreboard   ;

    function void build_phase (uvm_phase phase);
        afvip_apb_item_scoreboard   = new ("afvip_apb_item_scoreboard"  , this);
        afvip_intr_item_scoreboard  = new ("afvip_intr_item_scoreboard" , this);
        afvip_rst_item_scoreboard   = new ("afvip_rst_item_scoreboard"  , this);
    endfunction : build_phase
    // Local memory for APB scoreboard
    bit [2:0]   expected_opcode     ;
    bit [7:0]   expected_imm        ;
    bit [15:0]  expected_rs0        ;
    bit [15:0]  expected_rs1        ;
    bit [15:0]  expected_dst        ;
    bit [31:0]  expected_wdata  [32];
    bit [31:0]  expected_rdata  [32];
    // APB scoreboard
    virtual function void write_apb (afvip_apb_item item_apb);
        if (item_apb.testnr == 4 || item_apb.testnr == 6) begin
        // Reset the local array when reset is deasserted
        if (!item_apb.apb_rst) begin
            for (int i = 0; i <= 31; i++) begin
                expected_wdata [i]  = 0;
            end
        end
        // Confirm PADDR is multiple of 4
        if (item_apb.paddr [1:0] != 0) begin
            `uvm_error ("APB Scoreboard", $sformatf ("Address is not divisible by 4.", UVM_NONE))
        end
        // Data written at a valid write operation
        if (item_apb.pwrite && item_apb.psel && item_apb.penable && item_apb.paddr <= 124) begin
            expected_wdata [item_apb.paddr / 4] = item_apb.pwdata;
        end
        // Read data given by the DUT
            expected_rdata [item_apb.paddr / 4] = item_apb.prdata;
        // Extract instruction format to local variables
        if (item_apb.pwrite && item_apb.paddr == 16'h80) begin
            `uvm_info ("INSTR Scoreboard", $sformatf ("OPCODE: %d, RS0: %d, RS1: %d, DST: %d, IMM: %d", item_apb.opcode, item_apb.rs0, item_apb.rs1, item_apb.dst, item_apb.imm), UVM_NONE)
            expected_opcode = item_apb.opcode   ;
            expected_rs0    = item_apb.rs0      ;
            expected_rs1    = item_apb.rs1      ;
            expected_dst    = item_apb.dst      ;
            expected_imm    = item_apb.imm      ;
        end
        // Populate array for every working register
        if (!item_apb.pwrite && item_apb.paddr <= 124) begin
            if (expected_opcode == 0) begin
                expected_wdata [expected_dst] = expected_wdata [expected_rs0] + expected_imm;
            end
            if (expected_opcode == 1) begin
                expected_wdata [expected_dst] = expected_wdata [expected_rs0] * expected_imm;
            end
            if (expected_opcode == 2) begin
                expected_wdata [expected_dst] = expected_wdata [expected_rs0] + expected_wdata [expected_rs1];
            end
            if (expected_opcode == 3) begin
                expected_wdata [expected_dst] = expected_wdata [expected_rs0] * expected_wdata [expected_rs1];
            end
            if (expected_opcode == 4) begin
                expected_wdata [expected_dst] = expected_wdata [expected_rs0] * expected_wdata [expected_rs1] + expected_imm;
            end
            // Display scoreboard checker
            if (expected_wdata [item_apb.paddr / 4] == expected_rdata [item_apb.paddr / 4]) begin
                `uvm_info   ("APB Scoreboard", $sformatf ("Test passed. Received PRDATA: %h, Expected PRDATA: %h", expected_rdata [item_apb.paddr / 4], expected_wdata [item_apb.paddr / 4]), UVM_NONE)   
            end else begin
                `uvm_error  ("APB Scoreboard", $sformatf ("Test failed. Received PRDATA: %h, Expected PRDATA: %h", expected_rdata [item_apb.paddr / 4], expected_wdata [item_apb.paddr / 4]))   
            end
        end
    end
        
        endfunction : write_apb
    // Interrupt scoreboard placeholder
    virtual function void write_intr (afvip_intr_item item_intr);
        //
    endfunction : write_intr
    // Reset scoreboard placeholder
    virtual function void write_rst (afvip_rst_item item_rst);
        //
    endfunction : write_rst
    // Mandatory run_phase placeholder
    virtual task run_phase (uvm_phase phase);
        //
    endtask: run_phase

endclass : afvip_scoreboard