apio raw "yosys -p \"read_verilog top.v; show\" -q"
dot show.dot -Tsvg > diagram.svg
