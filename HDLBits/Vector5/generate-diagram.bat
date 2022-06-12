apio raw "yosys -p \"read_verilog top_module.v; show -colors 1 -width -stretch\" -q"
dot show.dot -Tsvg > diagram.svg
