apio raw "yosys -p \"read_verilog top.v; prep; show -colors 1 -width -stretch\" -q"
dot show.dot -Tsvg > diagram.svg
