interface afvip_sys_if (
    input       clk   ,
    input reg   rst_n
);

import uvm_pkg::*;

wire afvip_intr;

clocking cb_sys_rst_drv @ (posedge clk);
    output rst_n     ;
endclocking

clocking cb_sys_rst_mon @ (posedge clk);
    input rst_n     ;
endclocking

clocking cb_sys_intr_mon @ (posedge clk);
    input afvip_intr;
endclocking

endinterface : afvip_sys_if