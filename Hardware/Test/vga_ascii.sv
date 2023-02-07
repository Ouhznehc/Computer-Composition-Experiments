module vga_ascii(
    input   wire            pclk,
    input   wire            rst,
    input   wire            c_valid,
    input   wire    [11:0]  frontcolor,
    input   wire    [11:0]  backcolor,
    output  reg     [11:0]  vga_data,
    input   wire    [7:0]   char,
    input   wire    [3:0]   h_font,
    input   wire    [3:0]   v_font,
    input   wire            cursor
);
    reg [11:0] myfont[4095:0];
    wire [11:0] line;
    initial 
    begin
        $readmemh("C:/Users/24421/Desktop/Digital-Design/Hardware/Common/font.txt", myfont, 0, 4095);   
    end

    wire [11:0] out_data;
    wire cursorline;

    assign out_data = (line[h_font - 1] == 1'b1 | cursorline) ? frontcolor : backcolor;
    assign line = myfont[{char, v_font}];

    assign cursorline = cursor & (h_font == 4'd0); // i don't know why it doesn't work

    always @(posedge pclk)
    begin
        if(c_valid == 1'b1)
            vga_data <= out_data;
        else
            vga_data <= backcolor;
    end
endmodule