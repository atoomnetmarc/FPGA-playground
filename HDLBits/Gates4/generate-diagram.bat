apio raw "yosys -p \"read_verilog top_module.v; show\" -q"
dot show.dot -Tsvg > diagram.svg
