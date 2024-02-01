// -------------------------------------------------------------------------------------------------
// Module name: afvip_environment
// HDL        : System Verilog
// Author     : Vlad Botezatu
// Description: It has multiple agents, a scoreboard, a coverage collector and a virtual sequencer.
// Date       : 25 July, 2023
// -------------------------------------------------------------------------------------------------
class afvip_environment extends uvm_env;
    `uvm_component_utils (afvip_environment)
    // Constructor
    function new (string name = "afvip_environment", uvm_component parent = null);
        super.new (name, parent);
    endfunction : new
    
    // Agents handles
    afvip_apb_agent     i_afvip_apb_agent   ;
    afvip_intr_agent    i_afvip_intr_agent  ;
    afvip_rst_agent     i_afvip_rst_agent   ;
    // Scoreboard handle
    afvip_scoreboard    i_afvip_scoreboard  ;
    // Coverage handle
    afvip_coverage      i_afvip_coverage    ;
    // Virtual sequencer handle
    afvip_vsequencer    i_afvip_vsequencer  ;

    virtual function void build_phase (uvm_phase phase);
        super.build_phase (phase);
        // Coverage creation
        i_afvip_coverage    = afvip_coverage   :: type_id :: create ("i_afvip_coverage"  , this);
        // APB Agent creation
        i_afvip_apb_agent   = afvip_apb_agent  :: type_id :: create ("i_afvip_apb_agent" , this);
        // Passive interrupt agent creation and define
        i_afvip_intr_agent  = afvip_intr_agent :: type_id :: create ("i_afvip_intr_agent", this);
        i_afvip_intr_agent.is_active = UVM_PASSIVE;
        // Reset agent creation
        i_afvip_rst_agent   = afvip_rst_agent  :: type_id :: create ("i_afvip_rst_agent" , this);
        // Scoreboard creation
        i_afvip_scoreboard  = afvip_scoreboard :: type_id :: create ("i_afvip_scoreboard", this);
        // Virtual sequencer creation
        i_afvip_vsequencer  = afvip_vsequencer :: type_id :: create ("i_afvip_vsequencer", this);
    endfunction : build_phase

    virtual function void connect_phase (uvm_phase phase);
        super.connect_phase (phase);
        // Coverage
        i_afvip_apb_agent.i_afvip_apb_monitor.apb_mon_analysis_port.connect (i_afvip_coverage.analysis_export);
        // Agents
        i_afvip_apb_agent.i_afvip_apb_monitor.apb_mon_analysis_port.connect (i_afvip_scoreboard.afvip_apb_item_scoreboard);
        i_afvip_intr_agent.i_afvip_intr_monitor.intr_mon_analysis_port.connect (i_afvip_scoreboard.afvip_intr_item_scoreboard);
        i_afvip_rst_agent.i_afvip_rst_monitor.rst_mon_analysis_port.connect (i_afvip_scoreboard.afvip_rst_item_scoreboard);
        // Virtual sequencer
        i_afvip_vsequencer.vir_afvip_apb_sequencer = i_afvip_apb_agent.i_afvip_apb_sequencer;
    endfunction : connect_phase
endclass : afvip_environment