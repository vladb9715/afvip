module afvip_top;
    import uvm_pkg::*;
        `include "uvm_macros.svh"

    import afvip_test_pkg::*;
    
    // System Interface registers
    reg   clk       ;
    logic rst_n     ;
    logic afvip_intr;
    // APB Interface registers
    logic        psel   ;
    logic        penable;
    logic [15:0] paddr  ;
    logic        pwrite ;
    logic [31:0] pwdata ;
    logic        pready ;
    logic [31:0] prdata ;
    logic        pslverr;
    // Test number
    logic [ 3:0] testnr;
    // Test name
    string testsel;
    
    // 1 Ghz clock
    always begin #10 clk <= ~clk; end

    // System interface instantiation
    afvip_sys_if i_afvip_sys_interface (
        .clk        (clk)       ,
        .rst_n      (rst_n)
    );
    // APB interface instantiation
    afvip_apb_if i_afvip_apb_interface (
        .clk        (clk)       ,
        .rst_n      (rst_n)
    );
    // DUT instantiation
    afvip 
    #(
        .TP(0)  // Time Propagation
    ) i_afvip_hdl_top (
        .clk        (clk)       ,
        .rst_n      (rst_n)     ,
        .afvip_intr (afvip_intr),
        .psel       (psel)      ,
        .penable    (penable)   ,
        .paddr      (paddr)     ,
        .pwrite     (pwrite)    ,
        .pwdata     (pwdata)    ,
        .pready     (pready)    ,
        .prdata     (prdata)    ,
        .pslverr    (pslverr)
    );

    initial begin
        // Clock signal init
        clk <= 0;
        // Set virtual APB interface handle to all of the agents
        uvm_config_db #(virtual afvip_apb_if) :: set (null, "*.i_afvip_apb_agent.*" , "afvip_apb_interface", i_afvip_apb_interface);
        uvm_config_db #(virtual afvip_sys_if) :: set (null, "*.i_afvip_intr_agent.*", "afvip_sys_interface", i_afvip_sys_interface);
        uvm_config_db #(virtual afvip_sys_if) :: set (null, "*.i_afvip_rst_agent.*" , "afvip_sys_interface", i_afvip_sys_interface);
        
        // Test selector
        testnr = 4;
        
        // Test number conditions
        if (testnr == 0)    // Write only half of the register bits and then read all of the registers.
            testsel = "afvip_test_whalf_rall";  else
        if (testnr == 1)    // Write one, read one 10 times. Read 10 times. Write 10 times.
            testsel = "afvip_test_wone_rten";   else
        if (testnr == 2)    // Write one, read all of them.
            testsel = "afvip_test_wone_rall";   else
        if (testnr == 3)    // Write all registers, read all registers.
            testsel = "afvip_test_wall_rall";   else
        if (testnr == 4)    // Functional test - Feature 9.
            testsel = "afvip_test_functional";  else
        if (testnr == 5)    // Registers pattern test - Write 1s and 0s.
            testsel = "afvip_test_pattern";     else
        if (testnr == 6)    // Overlap - Random opcodes and random values for rs0 and rs1.
            testsel = "afvip_test_overlap";

        // Run desired test based on test number
        run_test (testsel);
    end

    // Inputs to DUT
    assign psel     = i_afvip_apb_interface.psel    ;
    assign penable  = i_afvip_apb_interface.penable ;
    assign paddr    = i_afvip_apb_interface.paddr   ;
    assign pwrite   = i_afvip_apb_interface.pwrite  ;
    assign pwdata   = i_afvip_apb_interface.pwdata  ;
    // Outputs from DUT
    assign i_afvip_apb_interface.pready     = pready    ;
    assign i_afvip_apb_interface.prdata     = prdata    ;
    assign i_afvip_apb_interface.pslverr    = pslverr   ;
    assign i_afvip_sys_interface.afvip_intr = afvip_intr;
    // Assign value to test number
    assign i_afvip_apb_interface.testnr     = testnr    ;

endmodule : afvip_top