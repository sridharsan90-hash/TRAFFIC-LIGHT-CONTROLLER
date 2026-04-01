// Traffic Light Controller FSM
// For EDA Playground (SystemVerilog)

module traffic_light_controller (
    input logic clk,
    input logic rst_n,
    output logic [2:0] light_main, // [2]Red, [1]Yellow, [0]Green
    output logic [2:0] light_side  // [2]Red, [1]Yellow, [0]Green
);

    // State Encoding for the Traffic Light
    typedef enum logic [1:0] {
        M_GRN_S_RED = 2'b00, // Main is Green, Side is Red
        M_YEL_S_RED = 2'b01, // Main is Yellow, Side is Red
        M_RED_S_GRN = 2'b10, // Main is Red, Side is Green
        M_RED_S_YEL = 2'b11  // Main is Red, Side is Yellow
    } state_t;

    state_t current_state, next_state;

    // Timer counter
    logic [4:0] timer;
    logic reset_timer;

    // Sequential blocks - State & Timer registers
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= M_GRN_S_RED;
            timer <= 0;
        end else begin
            current_state <= next_state;
            if (reset_timer)
                timer <= 0;
            else
                timer <= timer + 1;
        end
    end

    // Parameters for traffic light duration
    parameter GRN_TIME = 5'd12;
    parameter YEL_TIME = 5'd4;

    // Combinational logic for state transitions and light outputs
    always_comb begin
        // Default assignments (prevents latches)
        next_state = current_state;
        reset_timer = 0;
        
        // Default lights (both red for safety)
        light_main = 3'b100;
        light_side = 3'b100;

        case (current_state)
            M_GRN_S_RED: begin
                light_main = 3'b001; // Main Green
                light_side = 3'b100; // Side Red
                if (timer >= GRN_TIME) begin
                    next_state = M_YEL_S_RED;
                    reset_timer = 1;
                end
            end
            
            M_YEL_S_RED: begin
                light_main = 3'b010; // Main Yellow
                light_side = 3'b100; // Side Red
                if (timer >= YEL_TIME) begin
                    next_state = M_RED_S_GRN;
                    reset_timer = 1;
                end
            end
            
            M_RED_S_GRN: begin
                light_main = 3'b100; // Main Red
                light_side = 3'b001; // Side Green
                if (timer >= GRN_TIME) begin
                    next_state = M_RED_S_YEL;
                    reset_timer = 1;
                end
            end
            
            M_RED_S_YEL: begin
                light_main = 3'b100; // Main Red
                light_side = 3'b010; // Side Yellow
                if (timer >= YEL_TIME) begin
                    next_state = M_GRN_S_RED;
                    reset_timer = 1;
                end
            end
            
            default: next_state = M_GRN_S_RED;
        endcase
    end
endmodule
