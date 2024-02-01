// -----------------------------------------------------------------------------
// Module name: afvip_vsequence_lib
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Variety of virtual sequences library.
// Date       : 25 July, 2023
// -----------------------------------------------------------------------------

// Base virtual sequence needed to create streams of sequences.
class afvip_base_vsequence extends uvm_sequence #(afvip_apb_item);
  `uvm_object_utils (afvip_base_vsequence)
  
  `uvm_declare_p_sequencer (afvip_vsequencer)
  
  function new (string name = "afvip_base_vsequence");
    super.new (name);
  endfunction : new
  
endclass : afvip_base_vsequence
  
class afvip_vsequence_whalf_rall extends afvip_base_vsequence;
  `uvm_object_utils (afvip_vsequence_whalf_rall)
  
  typedef afvip_apb_sequence_write_half afvip_apb_sequence_write_half_t ;
  typedef afvip_apb_sequence_read_all   afvip_apb_sequence_read_all_t   ;
  
  function new (string name = "afvip_vsequence_whalf_rall");
    super.new (name);
  endfunction : new
  
  task body ();
    afvip_apb_sequence_write_half_t afvip_apb_seq_write_half;
    afvip_apb_sequence_read_all_t   afvip_apb_seq_read_all  ;
    
    afvip_apb_seq_write_half  = afvip_apb_sequence_write_half_t :: type_id :: create ("afvip_apb_seq_write_half") ;
    afvip_apb_seq_read_all    = afvip_apb_sequence_read_all_t   :: type_id :: create ("afvip_apb_seq_read_all")   ;

    // [Test] Write only half of the register bits and then read all of the registers
    afvip_apb_seq_write_half.start (p_sequencer.vir_afvip_apb_sequencer);
    afvip_apb_seq_read_all.start   (p_sequencer.vir_afvip_apb_sequencer);
  endtask : body
endclass : afvip_vsequence_whalf_rall

class afvip_vsequence_ten extends afvip_base_vsequence;
  `uvm_object_utils (afvip_vsequence_ten)

  typedef afvip_apb_sequence            afvip_apb_sequence_t        ;
  typedef afvip_apb_sequence_read       afvip_apb_sequence_read_t   ; 
  typedef afvip_apb_sequence_write      afvip_apb_sequence_write_t  ;

  function new (string name = "afvip_vsequence_ten");
    super.new (name);
  endfunction : new

  task body ();
    afvip_apb_sequence_t        afvip_apb_seq       ;
    afvip_apb_sequence_read_t   afvip_apb_seq_read  ;
    afvip_apb_sequence_write_t  afvip_apb_seq_write ;

    afvip_apb_seq       = afvip_apb_sequence_t       :: type_id :: create ("afvip_apb_seq")       ;
    afvip_apb_seq_read  = afvip_apb_sequence_read_t  :: type_id :: create ("afvip_apb_seq_read")  ;
    afvip_apb_seq_write = afvip_apb_sequence_write_t :: type_id :: create ("afvip_apb_seq_write") ;

    // [Test] Write one, read one 10 times. Read 10 times. Write 10 times.
    afvip_apb_seq.start       (p_sequencer.vir_afvip_apb_sequencer);
    afvip_apb_seq_read.start  (p_sequencer.vir_afvip_apb_sequencer);
    afvip_apb_seq_write.start (p_sequencer.vir_afvip_apb_sequencer);
  endtask : body
endclass : afvip_vsequence_ten

class afvip_vsequence_one extends afvip_base_vsequence;
  `uvm_object_utils (afvip_vsequence_one)

  typedef afvip_apb_sequence_write_one  afvip_apb_sequence_write_one_t  ;
  typedef afvip_apb_sequence_read_all   afvip_apb_sequence_read_all_t   ;

  function new (string name = "afvip_vsequence_one");
    super.new (name);
  endfunction : new

  task body ();
    afvip_apb_sequence_write_one_t  afvip_apb_seq_write_one ;
    afvip_apb_sequence_read_all_t   afvip_apb_seq_read_all  ;

    afvip_apb_seq_write_one   = afvip_apb_sequence_write_one_t  :: type_id :: create ("afvip_apb_seq_write_one");
    afvip_apb_seq_read_all    = afvip_apb_sequence_read_all_t   :: type_id :: create ("afvip_apb_seq_read_all") ;

    // [Test] Write one, read all of them.
    afvip_apb_seq_write_one.start (p_sequencer.vir_afvip_apb_sequencer);
    afvip_apb_seq_read_all.start  (p_sequencer.vir_afvip_apb_sequencer);
  endtask : body
endclass : afvip_vsequence_one

class afvip_vsequence_wall_rall extends afvip_base_vsequence;
  `uvm_object_utils (afvip_vsequence_wall_rall)

  typedef afvip_apb_sequence_write_all  afvip_apb_sequence_write_all_t  ;
  typedef afvip_apb_sequence_read_all   afvip_apb_sequence_read_all_t   ;

  function new (string name = "afvip_vsequence_wall_rall");
    super.new (name);
  endfunction : new

  task body ();
    afvip_apb_sequence_write_all_t  afvip_apb_seq_write_all ;
    afvip_apb_sequence_read_all_t   afvip_apb_seq_read_all  ;

    afvip_apb_seq_write_all   = afvip_apb_sequence_write_all_t  :: type_id :: create ("afvip_apb_seq_write_all");
    afvip_apb_seq_read_all    = afvip_apb_sequence_read_all_t   :: type_id :: create ("afvip_apb_seq_read_all") ;

    // [Test] Write all registers, read all registers.
    afvip_apb_seq_write_all.start (p_sequencer.vir_afvip_apb_sequencer);
    afvip_apb_seq_read_all.start  (p_sequencer.vir_afvip_apb_sequencer);
  endtask : body
endclass : afvip_vsequence_wall_rall

class afvip_vsequence_functional extends afvip_base_vsequence;
  `uvm_object_utils (afvip_vsequence_functional)
  // Forward declaration for the functional test
  typedef afvip_apb_functional_test afvip_apb_functional_test_t;
  // Constructor
  function new (string name = "afvip_vsequence_functional");
    super.new (name);
  endfunction : new

  task body ();
    afvip_apb_functional_test_t afvip_apb_func_test;

    afvip_apb_func_test = afvip_apb_functional_test_t :: type_id :: create ("afvip_apb_func_test");

    // [Test] Functional test - Feature 9
    afvip_apb_func_test.start (p_sequencer.vir_afvip_apb_sequencer);
  endtask : body
endclass : afvip_vsequence_functional

class afvip_vsequence_pattern extends afvip_base_vsequence;
  `uvm_object_utils (afvip_vsequence_pattern)
  // Forward declaration for the pattern test
  typedef afvip_apb_pattern_test afvip_apb_pattern_test_t;
  // Constructor
  function new (string name = "afvip_vsequence_pattern");
    super.new (name);
  endfunction : new

  task body ();
    afvip_apb_pattern_test_t afvip_apb_patt_test;

    afvip_apb_patt_test = afvip_apb_pattern_test_t :: type_id :: create ("afvip_apb_patt_test");

    // [Test] Registers pattern test - Write 1s and 0s
    afvip_apb_patt_test.start (p_sequencer.vir_afvip_apb_sequencer);
  endtask : body
endclass : afvip_vsequence_pattern

class afvip_vsequence_overlap extends afvip_base_vsequence;
  `uvm_object_utils (afvip_vsequence_overlap)
  // Forward declaration for the overlap test
  typedef afvip_overlap_test afvip_overlap_test_t;
  // Constructor
  function new (string name = "afvip_vsequence_overlap");
    super.new (name);
  endfunction : new

  task body ();
    afvip_overlap_test_t afvip_ovlp_test;

    afvip_ovlp_test = afvip_overlap_test_t :: type_id :: create ("afvip_ovlp_test");

    // [Test] Overlap - Random opcodes and random values for rs0 and rs1
    afvip_ovlp_test.start (p_sequencer.vir_afvip_apb_sequencer);
  endtask : body
endclass : afvip_vsequence_overlap