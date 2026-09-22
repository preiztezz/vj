module Address_Generator (
    input  wire        rst_i,
    input  wire        CLK25,    // 25 MHz clock
    input  wire        enable,   // Enable signal
    input  wire        vsync,    // Vertical sync signal
    output wire [16:0] address   // Generated address (17 bits)
);

    // Intermediate register signal (equivalent to 'val' in VHDL)
    reg [16:0] val = 17'd0;

    // Continuous assignment to drive the output address
    assign address = val;

    always @(posedge CLK25) begin
        if (rst_i) begin
            val <= 17'd0;
        end else begin
            if (enable) begin
                // 320 * 240 = 76800
                if (val < 17'd76800) begin
                    val <= val + 1'b1;
                end
            end
            
            if (!vsync) begin
                val <= 17'd0;
            end
        end
    end

endmodule
