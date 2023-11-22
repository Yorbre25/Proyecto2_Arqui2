module mainMemory #(parameter N = 24) (
  input logic [19:0] address_a, // Puerto 1: Dirección de lectura/escritura (24 bits)
  input logic [19:0] address_b, // Puerto 2: Dirección de lectura/escritura (24 bits)
  input logic [N-1:0] data_a, // Puerto 1: Datos de escritura (parámetro N bits)
  input logic [N-1:0] data_b, // Puerto 2: Datos de escritura (parámetro N bits)
  input logic wren_a, // Puerto 1: Habilitar escritura
  input logic wren_b, // Puerto 2: Habilitar escritura
  input logic clk, // Reloj
  output logic [N-1:0] q_a, // Puerto 1: Datos de lectura (parámetro N bits)
  output logic [N-1:0] q_b // Puerto 2: Datos de lectura (parámetro N bits)
);
  (* ramstyle = "M9K" *) // Directiva para inferir bloques de memoria M9K

  logic [N-1:0] memory [0:524287]; // Declaración de la memoria paramétrica

  always_ff @(posedge clk) begin
    if (wren_a)
      memory[address_a] <= data_a;
    if (wren_b)
      memory[address_b] <= data_b;
  end

  always_ff @(posedge clk) begin
    q_a <= wren_a ? memory[address_a] : {N{1'b0}};; // Leer en flanco positivo si wren_a está habilitado
    q_b <= wren_b ? memory[address_b] : {N{1'b0}}; // Leer en flanco positivo si wren_b está habilitado
  end

endmodule
