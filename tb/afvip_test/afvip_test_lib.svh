// -------------------------------------------------------------------------------------
// Module name: afvip_test_lib
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: Test library used to run different sequences on the virtual sequencer.
// Date       : 25 July, 2023
// -------------------------------------------------------------------------------------
class afvip_base_test extends uvm_test;
    //uvm_tlm_analysis_fifo #(afvip_intr_item) fifo_interrupt;
    `uvm_component_utils (afvip_base_test)
    // Constructor
    function new (string name = "afvip_base_test", uvm_component parent = null);
        super.new (name, parent);
        //fifo_interrupt = new ("fifo_interrupt", this);
    endfunction : new

    afvip_environment i_afvip_environment;

    virtual function void build_phase (uvm_phase phase);
        i_afvip_environment = afvip_environment :: type_id :: create ("i_afvip_environment", this);
    endfunction

    virtual function void connect_phase (uvm_phase phase);
        super.connect_phase (phase);
        //i_afvip_environment.i_afvip_intr_agent.i_afvip_intr_monitor.intr_mon_analysis_port.connect (fifo_interrupt.analysis_export);
    endfunction : connect_phase

    virtual function void end_of_elaboration_phase (uvm_phase phase);
        uvm_top.print_topology ();
    endfunction

    /*task wait_interrupt ();
        afvip_intr_item interrupt_item;
        fifo_interrupt.get (interrupt_item);
    endtask : wait_interrupt*/

    /*virtual task run_phase (uvm_phase phase);
        //
    endtask : run_phase*/

endclass : afvip_base_test

class afvip_test_whalf_rall extends afvip_base_test;
    `uvm_component_utils (afvip_test_whalf_rall)
    // Constructor
    function new (string name = "afvip_test_whalf_rall", uvm_component parent = null);
        super.new (name, parent);
    endfunction : new

    afvip_environment i_afvip_environment;

    virtual function void build_phase (uvm_phase phase);
        i_afvip_environment = afvip_environment :: type_id :: create ("i_afvip_environment", this);
    endfunction

    virtual function void end_of_elaboration_phase (uvm_phase phase);
        uvm_top.print_topology ();
    endfunction

    virtual task run_phase (uvm_phase phase);

        afvip_vsequence_whalf_rall  vit_afvip_vsequence_whalf_rall;
        afvip_rst_sequence          vit_afvip_rst_sequence;
        
        vit_afvip_vsequence_whalf_rall  = afvip_vsequence_whalf_rall :: type_id :: create ("vit_afvip_vsequence_whalf_rall");
        vit_afvip_rst_sequence          = afvip_rst_sequence :: type_id :: create ("vit_afvip_rst_sequence");
        
        phase.raise_objection (this);
        
        vit_afvip_rst_sequence.start (i_afvip_environment.i_afvip_rst_agent.i_afvip_rst_sequencer);
        vit_afvip_vsequence_whalf_rall.start (i_afvip_environment.i_afvip_vsequencer);

        phase.drop_objection (this);
    endtask : run_phase
endclass : afvip_test_whalf_rall

class afvip_test_wall_rall extends afvip_base_test;
    `uvm_component_utils (afvip_test_wall_rall)
    // Constructor
    function new (string name = "afvip_test_wall_rall", uvm_component parent = null);
        super.new (name, parent);
    endfunction : new

    afvip_environment i_afvip_environment;

    virtual function void build_phase (uvm_phase phase);
        i_afvip_environment = afvip_environment :: type_id :: create ("i_afvip_environment", this);
    endfunction

    virtual function void end_of_elaboration_phase (uvm_phase phase);
        uvm_top.print_topology ();
    endfunction

    virtual task run_phase (uvm_phase phase);
        afvip_vsequence_wall_rall   vit_afvip_vsequence_wall_rall;
        afvip_rst_sequence          vit_afvip_rst_sequence;
        
        vit_afvip_vsequence_wall_rall   = afvip_vsequence_wall_rall :: type_id :: create ("vit_afvip_vsequence_wall_rall");
        vit_afvip_rst_sequence          = afvip_rst_sequence :: type_id :: create ("vit_afvip_rst_sequence");
        
        phase.raise_objection (this);
        
        vit_afvip_rst_sequence.start (i_afvip_environment.i_afvip_rst_agent.i_afvip_rst_sequencer);
        vit_afvip_vsequence_wall_rall.start (i_afvip_environment.i_afvip_vsequencer);

        phase.drop_objection (this);
    endtask : run_phase
endclass : afvip_test_wall_rall

class afvip_test_functional extends afvip_base_test;
    `uvm_component_utils (afvip_test_functional)
    // Constructor
    function new (string name = "afvip_test_functional", uvm_component parent = null);
        super.new (name, parent);
    endfunction : new

    afvip_environment i_afvip_environment;

    virtual function void build_phase (uvm_phase phase);
        i_afvip_environment = afvip_environment :: type_id :: create ("i_afvip_environment", this);
    endfunction

    virtual function void end_of_elaboration_phase (uvm_phase phase);
        uvm_top.print_topology ();
    endfunction

    virtual task run_phase (uvm_phase phase);
        afvip_vsequence_functional  vit_afvip_vsequence_functional;
        afvip_rst_sequence          vit_afvip_rst_sequence;
        
        vit_afvip_vsequence_functional  = afvip_vsequence_functional :: type_id :: create ("vit_afvip_vsequence_functional");
        vit_afvip_rst_sequence          = afvip_rst_sequence :: type_id :: create ("vit_afvip_rst_sequence");
        
        phase.raise_objection (this);
        
        vit_afvip_rst_sequence.start (i_afvip_environment.i_afvip_rst_agent.i_afvip_rst_sequencer);
        vit_afvip_vsequence_functional.start (i_afvip_environment.i_afvip_vsequencer);

        phase.drop_objection (this);
    endtask : run_phase
endclass : afvip_test_functional

class afvip_test_wone_rall extends afvip_base_test;
    `uvm_component_utils (afvip_test_wone_rall)
    // Constructor
    function new (string name = "afvip_test_wone_rall", uvm_component parent = null);
        super.new (name, parent);
    endfunction : new

    afvip_environment i_afvip_environment;

    virtual function void build_phase (uvm_phase phase);
        i_afvip_environment = afvip_environment :: type_id :: create ("i_afvip_environment", this);
    endfunction

    virtual function void end_of_elaboration_phase (uvm_phase phase);
        uvm_top.print_topology ();
    endfunction

    virtual task run_phase (uvm_phase phase);
        afvip_vsequence_one     vit_afvip_vsequence_one;
        afvip_rst_sequence      vit_afvip_rst_sequence;
        
        vit_afvip_vsequence_one = afvip_vsequence_one :: type_id :: create ("vit_afvip_vsequence_one");
        vit_afvip_rst_sequence  = afvip_rst_sequence :: type_id :: create ("vit_afvip_rst_sequence");
        
        phase.raise_objection (this);
        
        vit_afvip_rst_sequence.start (i_afvip_environment.i_afvip_rst_agent.i_afvip_rst_sequencer);
        vit_afvip_vsequence_one.start (i_afvip_environment.i_afvip_vsequencer);

        phase.drop_objection (this);
    endtask : run_phase
endclass : afvip_test_wone_rall

class afvip_test_wone_rten extends afvip_base_test;
    `uvm_component_utils (afvip_test_wone_rten)
    // Constructor
    function new (string name = "afvip_test_wone_rten", uvm_component parent = null);
        super.new (name, parent);
    endfunction : new

    afvip_environment i_afvip_environment;

    virtual function void build_phase (uvm_phase phase);
        i_afvip_environment = afvip_environment :: type_id :: create ("i_afvip_environment", this);
    endfunction

    virtual function void end_of_elaboration_phase (uvm_phase phase);
        uvm_top.print_topology ();
    endfunction

    virtual task run_phase (uvm_phase phase);
        afvip_vsequence_ten     vit_afvip_vsequence_ten;
        afvip_rst_sequence      vit_afvip_rst_sequence;
        
        vit_afvip_vsequence_ten = afvip_vsequence_ten :: type_id :: create ("vit_afvip_vsequence_ten");
        vit_afvip_rst_sequence  = afvip_rst_sequence :: type_id :: create ("vit_afvip_rst_sequence");
        
        phase.raise_objection (this);
        
        vit_afvip_rst_sequence.start (i_afvip_environment.i_afvip_rst_agent.i_afvip_rst_sequencer);
        vit_afvip_vsequence_ten.start (i_afvip_environment.i_afvip_vsequencer);

        phase.drop_objection (this);
    endtask : run_phase
endclass : afvip_test_wone_rten

class afvip_test_pattern extends afvip_base_test;
    `uvm_component_utils (afvip_test_pattern)
    // Constructor
    function new (string name = "afvip_test_pattern", uvm_component parent = null);
        super.new (name, parent);
    endfunction : new

    afvip_environment i_afvip_environment;

    virtual function void build_phase (uvm_phase phase);
        i_afvip_environment = afvip_environment :: type_id :: create ("i_afvip_environment", this);
    endfunction

    virtual function void end_of_elaboration_phase (uvm_phase phase);
        uvm_top.print_topology ();
    endfunction

    virtual task run_phase (uvm_phase phase);
        afvip_vsequence_pattern vit_afvip_vsequence_pattern;
        afvip_rst_sequence      vit_afvip_rst_sequence;

        vit_afvip_vsequence_pattern = afvip_vsequence_pattern :: type_id :: create ("vit_afvip_vsequence_pattern");
        vit_afvip_rst_sequence      = afvip_rst_sequence :: type_id :: create ("vit_afvip_rst_sequence");

        phase.raise_objection (this);

        vit_afvip_rst_sequence.start (i_afvip_environment.i_afvip_rst_agent.i_afvip_rst_sequencer);
        vit_afvip_vsequence_pattern.start (i_afvip_environment.i_afvip_vsequencer);

        phase.drop_objection (this);
    endtask : run_phase
endclass : afvip_test_pattern

class afvip_test_overlap extends afvip_base_test;
    `uvm_component_utils (afvip_test_overlap)
    // Constructor
    function new (string name = "afvip_test_overlap", uvm_component parent = null);
        super.new (name, parent);
    endfunction : new

    afvip_environment i_afvip_environment;

    virtual function void build_phase (uvm_phase phase);
        i_afvip_environment = afvip_environment :: type_id :: create ("i_afvip_environment", this);
    endfunction

    virtual function void end_of_elaboration_phase (uvm_phase phase);
        uvm_top.print_topology ();
    endfunction

    virtual task run_phase (uvm_phase phase);
        afvip_vsequence_overlap vit_afvip_vsequence_overlap;
        afvip_rst_sequence      vit_afvip_rst_sequence;
        afvip_rst_sequence_fork vit_afvip_rst_sequence_fork;
        
        vit_afvip_vsequence_overlap = afvip_vsequence_overlap :: type_id :: create ("vit_afvip_vsequence_overlap");
        vit_afvip_rst_sequence      = afvip_rst_sequence :: type_id :: create ("vit_afvip_rst_sequence");
        vit_afvip_rst_sequence_fork = afvip_rst_sequence_fork :: type_id :: create ("vit_afvip_rst_sequence_fork");

        phase.raise_objection (this);

        vit_afvip_rst_sequence.start (i_afvip_environment.i_afvip_rst_agent.i_afvip_rst_sequencer);
        // [Test with reset]
        fork
        vit_afvip_vsequence_overlap.start (i_afvip_environment.i_afvip_vsequencer);
        vit_afvip_rst_sequence_fork.start (i_afvip_environment.i_afvip_rst_agent.i_afvip_rst_sequencer);
        join

        // [Test without reset]
        // vit_afvip_vsequence_overlap.start (i_afvip_environment.i_afvip_vsequencer);
        phase.drop_objection (this);
    endtask : run_phase
endclass : afvip_test_overlap