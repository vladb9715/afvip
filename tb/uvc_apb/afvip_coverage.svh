// -----------------------------------------------------------------------------
// Module name: afvip_coverage
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Coverage percentage information and database storage.
// Date       : 25 July, 2023
// -----------------------------------------------------------------------------
class afvip_coverage extends uvm_subscriber #(afvip_apb_item);
    `uvm_component_utils (afvip_coverage)
    // Constructor
    function new (string name = "afvip_coverage", uvm_component parent);
        super.new (name, parent);
        cg_addr     = new ();
        cg_opcode   = new ();
        cg_pwdata   = new ();
        cg_rs0      = new ();
        cg_rs1      = new ();
        cg_dst      = new ();
      endfunction
    // Extract phase variables declaration
    real paddr_ep_cov   ;
    real opcode_ep_cov  ;
    real pwdata_ep_cov  ;
    real rs0_ep_cov     ;
    real rs1_ep_cov     ;
    real dst_ep_cov     ;
    // APB item handle
    afvip_apb_item cov_afvip_apb_item;
    // Complete address covergroup
    covergroup cg_addr;
        PADDR: coverpoint cov_afvip_apb_item.paddr/4 {
            bins paddr [32] = {[0:31]};
        }
    endgroup : cg_addr
    // Cover all valid opcodes
    covergroup cg_opcode;
        OPCODE: coverpoint cov_afvip_apb_item.opcode {
            bins opcode [5] = {[0:4]};
        }
    endgroup : cg_opcode
    // Cover all valid addresses for RS0
    covergroup cg_rs0;
        RS0: coverpoint cov_afvip_apb_item.rs0 {
            bins rs0 [32] = {[5'd0:5'd31]};
        }
    endgroup : cg_rs0
    // Cover all valid addresses for RS1
    covergroup cg_rs1;
        RS1: coverpoint cov_afvip_apb_item.rs1 {
            bins rs1 [32] = {[5'd0:5'd31]};
        }
    endgroup : cg_rs1
    // Cover all valid addresses for DST
    covergroup cg_dst;
        DST: coverpoint cov_afvip_apb_item.dst {
            bins dst [32] = {[5'd0:5'd31]};
        }
    endgroup : cg_dst
    // Cover intervals of PWDATA
    covergroup cg_pwdata;
        PWDATA: coverpoint cov_afvip_apb_item.pwdata {
            bins pwdataintervals [] =   {   [32'h00000000:32'h000000FF],
                                            [32'h00000100:32'h0000FFFF],
                                            [32'h00010000:32'h00FFFFFF],
                                            [32'h01000000:32'h0FFFFFFF]
                                        };
        }
    endgroup : cg_pwdata
    // Sample coverpoints within covergroups
    function void write (afvip_apb_item t);
        cov_afvip_apb_item = t;
        cg_addr.sample ();
        cg_opcode.sample ();
        cg_pwdata.sample ();
        cg_rs0.sample ();
        cg_rs1.sample ();
        cg_dst.sample ();
    endfunction : write
    // Extract and compute expected data from covergroups
    function void extract_phase (uvm_phase phase);
        super.extract_phase (phase);
        paddr_ep_cov    = cg_addr.get_coverage ();
        opcode_ep_cov   = cg_opcode.get_coverage ();
        pwdata_ep_cov   = cg_pwdata.get_coverage ();
        rs0_ep_cov      = cg_rs0.get_coverage ();
        rs1_ep_cov      = cg_rs1.get_coverage ();
        dst_ep_cov      = cg_dst.get_coverage ();
    endfunction : extract_phase
    // Display coverage results
    function void report_phase (uvm_phase phase);
        super.report_phase (phase);
        `uvm_info ("PADDR Coverage", $sformatf ("Coverage is %0.2f", paddr_ep_cov), UVM_MEDIUM)
        `uvm_info ("OPCODE Coverage", $sformatf ("Coverage is %0.2f", opcode_ep_cov), UVM_MEDIUM)
        `uvm_info ("RS0 Coverage", $sformatf ("Coverage is %0.2f", rs0_ep_cov), UVM_MEDIUM)
        `uvm_info ("RS1 Coverage", $sformatf ("Coverage is %0.2f", rs1_ep_cov), UVM_MEDIUM)
        `uvm_info ("DST Coverage", $sformatf ("Coverage is %0.2f", dst_ep_cov), UVM_MEDIUM)
        `uvm_info ("PWDATA Coverage", $sformatf ("Coverage is %0.8f", pwdata_ep_cov), UVM_MEDIUM)
    endfunction : report_phase
    
endclass : afvip_coverage