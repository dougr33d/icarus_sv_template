module top();

localparam RST_CYCLES=8;
localparam MAX_CYCLES=100;

////////////////////////////////////////
// Nets ////////////////////////////////
////////////////////////////////////////

logic clk;
logic rst;

////////////////////////////////////////
// Clocking ////////////////////////////
////////////////////////////////////////

initial begin
    clk = 1'b0;
end

always begin
    #10
    clk <= ~clk;
end

////////////////////////////////////////
// Reset ///////////////////////////////
////////////////////////////////////////

initial begin
    rst = 1'b1;

    repeat(RST_CYCLES) @(negedge clk);
    rst = 1'b0;
end

////////////////////////////////////////
// Timeout /////////////////////////////
////////////////////////////////////////

initial begin
    repeat(MAX_CYCLES) @(posedge clk);
    $display("Hit cycle timeout %d", MAX_CYCLES);
    $finish();
end

////////////////////////////////////////
// Waves ///////////////////////////////
////////////////////////////////////////

string fn_waves;
initial begin
    if ($value$plusargs("waves:%s", fn_waves)) begin
        $dumpfile(fn_waves);
        $dumpvars(0,top);
    end
end

////////////////////////////////////////
// DUT /////////////////////////////////
////////////////////////////////////////

dut dut (
    .clk,
    .rst
);

endmodule
