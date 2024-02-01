// -----------------------------------------------------------------------------
// Module name: afvip_apb_sequence
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Streams of sequences for registers testing.
// Date       : 25 July, 2023
// -----------------------------------------------------------------------------

// Base sequence needed to create streams of sequences.
class afvip_apb_base_sequence extends uvm_sequence;
    `uvm_object_utils (afvip_apb_base_sequence)

    function new (string name = "afvip_apb_base_sequence");
        super.new (name);
    endfunction : new

    virtual task body ();
    endtask : body
endclass : afvip_apb_base_sequence

// Write one register, read on register 10 times.
class afvip_apb_sequence extends afvip_apb_base_sequence;
    `uvm_object_utils (afvip_apb_sequence)

    function new (string name = "afvip_apb_sequence");
        super.new (name);
    endfunction : new

    virtual task body ();
        afvip_apb_item vit_afvip_apb_item;

        vit_afvip_apb_item = afvip_apb_item :: type_id :: create ("vit_afvip_apb_item");

        for (int i = 0; i < 10; i++) begin

        start_item (vit_afvip_apb_item);
        
        if  (!(vit_afvip_apb_item.randomize () with {   
                                                    paddr [1:0] == 0;
                                                    paddr inside {[0:16'h7C]};
                                                    pwrite == 1; 
                                                    pwdata == (i+4);
                                                    }
            ))
            `uvm_error (get_type_name (), "Rand error!")

        finish_item (vit_afvip_apb_item);

        start_item (vit_afvip_apb_item);
            vit_afvip_apb_item.pwrite = 0;
        finish_item (vit_afvip_apb_item);

        end
    endtask : body
endclass : afvip_apb_sequence

// Read 10 registers.
class afvip_apb_sequence_read extends afvip_apb_base_sequence;
    `uvm_object_utils (afvip_apb_sequence_read)

    function new (string name = "afvip_apb_sequence_read");
        super.new (name);
    endfunction : new

    virtual task body ();
        afvip_apb_item vit_afvip_apb_item;

        vit_afvip_apb_item = afvip_apb_item :: type_id :: create ("vit_afvip_apb_item");

        for (int i = 0; i < 10; i++) begin

        start_item (vit_afvip_apb_item);
        
        if  (!(vit_afvip_apb_item.randomize () with {
                                                    paddr [1:0] == 0;
                                                    paddr inside {[0:16'h7C]};
                                                    pwrite == 0;
                                                    }
            ))
            `uvm_error (get_type_name (), "Rand error!")

        finish_item (vit_afvip_apb_item);

        end
    endtask : body
endclass : afvip_apb_sequence_read

// Write 10 registers.
class afvip_apb_sequence_write extends afvip_apb_base_sequence;
    `uvm_object_utils (afvip_apb_sequence_write)

    function new (string name = "afvip_apb_sequence_write");
        super.new (name);
    endfunction : new

    virtual task body ();
        afvip_apb_item vit_afvip_apb_item;

        vit_afvip_apb_item = afvip_apb_item :: type_id :: create ("vit_afvip_apb_item");

        for (int i = 0; i < 10; i++) begin

        start_item (vit_afvip_apb_item);
        
        if  (!(vit_afvip_apb_item.randomize () with {
                                                    paddr [1:0] == 0;
                                                    paddr  inside {[0:16'h7C]};
                                                    pwrite == 1; 
                                                    pwdata == (i+4);
                                                    }
            ))
            `uvm_error (get_type_name (), "Rand error!")

        finish_item (vit_afvip_apb_item);

        end
    endtask : body
endclass : afvip_apb_sequence_write

// Write one register.
class afvip_apb_sequence_write_one extends afvip_apb_base_sequence;
    `uvm_object_utils (afvip_apb_sequence_write_one)

    function new (string name = "afvip_apb_sequence_write_one");
        super.new (name);
    endfunction : new

    virtual task body ();
        afvip_apb_item vit_afvip_apb_item;

        vit_afvip_apb_item = afvip_apb_item :: type_id :: create ("vit_afvip_apb_item");

        start_item (vit_afvip_apb_item);
        
        if  (!(vit_afvip_apb_item.randomize () with {   
                                                    paddr [1:0] == 0;
                                                    paddr inside {[0:16'h7C]};
                                                    pwrite == 1;
                                                    pwdata == 32'hD4F0;
                                                    }
            ))
            `uvm_error (get_type_name (), "Rand error!")

        finish_item (vit_afvip_apb_item);
    endtask : body
endclass : afvip_apb_sequence_write_one

// Write all registers.
class afvip_apb_sequence_write_all extends afvip_apb_base_sequence;
    `uvm_object_utils (afvip_apb_sequence_write_all)

    function new (string name = "afvip_apb_sequence_write_all");
        super.new (name);
    endfunction : new

    virtual task body ();
        afvip_apb_item vit_afvip_apb_item;

        vit_afvip_apb_item = afvip_apb_item :: type_id :: create ("vit_afvip_apb_item");

        for (int i = 0; i <= 124; i = i + 4) begin

        start_item (vit_afvip_apb_item);
        
        if  (!(vit_afvip_apb_item.randomize () with {   
                                                    paddr [1:0] == 0;
                                                    paddr inside {[0:16'h7C]};
                                                    paddr  == i;
                                                    pwrite == 1; 
                                                    pwdata == (i+4);
                                                    }
            ))
            `uvm_error (get_type_name (), "Rand error!")

        finish_item (vit_afvip_apb_item);

        end
    endtask : body
endclass : afvip_apb_sequence_write_all

// Read all registers.
class afvip_apb_sequence_read_all extends afvip_apb_base_sequence;
    `uvm_object_utils (afvip_apb_sequence_read_all)

    function new (string name = "afvip_apb_sequence_read_all");
        super.new (name);
    endfunction : new

    virtual task body ();
        afvip_apb_item vit_afvip_apb_item;

        vit_afvip_apb_item = afvip_apb_item :: type_id :: create ("vit_afvip_apb_item");

        for (int i = 0; i <= 124; i = i + 4) begin

        start_item (vit_afvip_apb_item);
        
        if  (!(vit_afvip_apb_item.randomize () with {
                                                    paddr [1:0] == 0;
                                                    paddr inside {[0:16'h7C]};
                                                    paddr  == i;
                                                    pwrite == 0;
                                                    pwdata == 0;
                                                    }
            ))
            `uvm_error (get_type_name (), "Rand error!")

        finish_item (vit_afvip_apb_item);

        end
    endtask : body
endclass : afvip_apb_sequence_read_all

// Functional test - Feature 9.
class afvip_apb_functional_test extends afvip_apb_base_sequence;
    `uvm_object_utils (afvip_apb_functional_test)

    function new (string name = "afvip_apb_functional_test");
        super.new (name);
    endfunction : new

    virtual task body ();
        afvip_apb_item vit_afvip_apb_item;

        vit_afvip_apb_item  = afvip_apb_item  :: type_id :: create ("vit_afvip_apb_item");
        
        for (int i = 2, j = 8; i <= 31 & j <= 124; i++, j = j + 4) begin
        start_item (vit_afvip_apb_item);
            vit_afvip_apb_item.paddr    = 16'h00;   // Select first register as RS0
            vit_afvip_apb_item.pwdata   = $urandom_range(0, 256)     ;
            vit_afvip_apb_item.pwrite   = 1     ;
        finish_item (vit_afvip_apb_item);

        start_item (vit_afvip_apb_item);
            vit_afvip_apb_item.paddr    = 16'h04;   // Select second register as RS1
            vit_afvip_apb_item.pwdata   = $urandom_range (0, 128)     ;
            vit_afvip_apb_item.pwrite   = 1     ;
        finish_item (vit_afvip_apb_item);

        start_item (vit_afvip_apb_item);
            vit_afvip_apb_item.paddr            = 16'h80                ;   // Instruction register
            vit_afvip_apb_item.pwdata [2:0]     = $urandom_range(0, 4)  ;   // OPCODE assign
            vit_afvip_apb_item.pwdata [7:3]     = 5'd0                  ;   // RS0 address
            vit_afvip_apb_item.pwdata [12:8]    = 5'd1                  ;   // RS1 address
            vit_afvip_apb_item.pwdata [20:16]   = i                     ;   // DST location
            vit_afvip_apb_item.pwdata [31:24]   = $urandom_range (0, 63)                  ;   // IMM value
            vit_afvip_apb_item.pwrite           = 1                     ;
        finish_item (vit_afvip_apb_item);

        // start_item (vit_afvip_apb_item);
        //     vit_afvip_apb_item.paddr    = 16'h8C;   // Start operation
        //     vit_afvip_apb_item.pwdata   = 1     ;
        //     vit_afvip_apb_item.pwrite   = 1     ;
        // finish_item (vit_afvip_apb_item);

        start_item (vit_afvip_apb_item);
            vit_afvip_apb_item.paddr    = 16'h84;   // Read interrupt status
            vit_afvip_apb_item.pwrite   = 0     ;
        finish_item (vit_afvip_apb_item);

        start_item (vit_afvip_apb_item);
            vit_afvip_apb_item.paddr    = 16'h88;   // Clear interrupt
            vit_afvip_apb_item.pwdata   = 2     ;   // Finish interrupt
            vit_afvip_apb_item.pwrite   = 1     ;
        finish_item (vit_afvip_apb_item);

        start_item (vit_afvip_apb_item);
            vit_afvip_apb_item.paddr    = j;        // Read destination register
            vit_afvip_apb_item.pwrite   = 0;
        finish_item (vit_afvip_apb_item);
        end

    endtask : body
endclass : afvip_apb_functional_test

// Write half of the register bits.
class afvip_apb_sequence_write_half extends afvip_apb_base_sequence;
    `uvm_object_utils (afvip_apb_sequence_write_half)

    function new (string name = "afvip_apb_sequence_write_half");
        super.new (name);
    endfunction : new

    virtual task body ();
        afvip_apb_item vit_afvip_apb_item;

        vit_afvip_apb_item = afvip_apb_item :: type_id :: create ("vit_afvip_apb_item");

        for (int i = 0; i <= 124; i = i + 4) begin

        start_item (vit_afvip_apb_item);
        
        if  (!(vit_afvip_apb_item.randomize () with {   
                                                    paddr [1:0] == 0;
                                                    paddr inside {[0:16'h7C]};
                                                    paddr  == i;
                                                    pwrite == 1; 
                                                    pwdata [31:16] == (i+4);
                                                    pwdata [15:0] == 0;
                                                    }
            ))
            `uvm_error (get_type_name (), "Rand error!")

        finish_item (vit_afvip_apb_item);

        end
    endtask : body
endclass : afvip_apb_sequence_write_half

// Registers pattern test - Write 1s and 0s.
class afvip_apb_pattern_test extends afvip_apb_base_sequence;
    `uvm_object_utils (afvip_apb_pattern_test)

    function new (string name = "afvip_apb_pattern_test");
        super.new (name);
    endfunction : new

    virtual task body ();
        afvip_apb_item vit_afvip_apb_item;

        vit_afvip_apb_item = afvip_apb_item :: type_id :: create ("vit_afvip_apb_item");

        for (int unsigned i = 0, j = 1; i <= 124 & j <= 2200000000; i = i + 4, j = j * 2) begin
        start_item (vit_afvip_apb_item);
        
        if  (!(vit_afvip_apb_item.randomize () with {   
                                                    paddr [1:0] == 0;
                                                    paddr inside {[0:16'h7C]};
                                                    paddr  == i;
                                                    pwrite == 1; 
                                                    pwdata == j;
                                                    }
            ))
            `uvm_error (get_type_name (), "Rand error!")

        finish_item (vit_afvip_apb_item);

        start_item (vit_afvip_apb_item);
            vit_afvip_apb_item.pwrite = 0;
        finish_item (vit_afvip_apb_item);

        end
    endtask : body
endclass : afvip_apb_pattern_test

// Overlap test - Random opcodes and random values for rs0 and rs1.
class afvip_overlap_test extends afvip_apb_base_sequence;
    `uvm_object_utils (afvip_overlap_test)

    function new (string name = "afvip_overlap_test");
        super.new (name);
    endfunction : new

    virtual task body ();
        afvip_apb_item vit_afvip_apb_item;

        vit_afvip_apb_item  = afvip_apb_item  :: type_id :: create ("vit_afvip_apb_item");

        for (int i = 2, j = 8; i <= 31 & j <= 124; i++, j = j + 4) begin
        // Select first register as RS0
        start_item (vit_afvip_apb_item);
            vit_afvip_apb_item.paddr    = 16'h00                                    ;
            vit_afvip_apb_item.pwdata   = $urandom_range(32'hFFFFFF00, 32'hFFFFFFFF);
            vit_afvip_apb_item.pwrite   = 1                                         ;
        finish_item (vit_afvip_apb_item);
        // Select second register as RS1
        start_item (vit_afvip_apb_item);
            vit_afvip_apb_item.paddr    = 16'h04                ;
            vit_afvip_apb_item.pwdata   = $urandom_range(2, 5)  ;
            vit_afvip_apb_item.pwrite   = 1                     ;
        finish_item (vit_afvip_apb_item);

        start_item (vit_afvip_apb_item);
            vit_afvip_apb_item.paddr            = 16'h80                ;   // Instruction register
            vit_afvip_apb_item.pwdata [2:0]     = $urandom_range(0, 4)  ;   // OPCODE assign
            vit_afvip_apb_item.pwdata [7:3]     = 5'd0                  ;   // RS0 address
            vit_afvip_apb_item.pwdata [12:8]    = 5'd1                  ;   // RS1 address
            vit_afvip_apb_item.pwdata [20:16]   = i                     ;   // DST location
            vit_afvip_apb_item.pwdata [31:24]   = 8'd6                  ;   // IMM value
            vit_afvip_apb_item.pwrite           = 1                     ;
        finish_item (vit_afvip_apb_item);

        start_item (vit_afvip_apb_item);
            vit_afvip_apb_item.paddr    = 16'h8C;  // Start operation
            vit_afvip_apb_item.pwdata   = 1     ;
            vit_afvip_apb_item.pwrite   = 1     ;
        finish_item (vit_afvip_apb_item);

        start_item (vit_afvip_apb_item);
            vit_afvip_apb_item.paddr    = 16'h84;   // Read interrupt status
            vit_afvip_apb_item.pwrite   = 0     ;
        finish_item (vit_afvip_apb_item);

        start_item (vit_afvip_apb_item);
            vit_afvip_apb_item.paddr    = 16'h88;   // Clear interrupt
            vit_afvip_apb_item.pwdata   = 2     ;   // Finish interrupt
            vit_afvip_apb_item.pwrite   = 1     ;
        finish_item (vit_afvip_apb_item);

        start_item (vit_afvip_apb_item);
            vit_afvip_apb_item.paddr    = j;        // Read destination register
            vit_afvip_apb_item.pwrite   = 0;
        finish_item (vit_afvip_apb_item);
        end

    endtask : body
endclass : afvip_overlap_test