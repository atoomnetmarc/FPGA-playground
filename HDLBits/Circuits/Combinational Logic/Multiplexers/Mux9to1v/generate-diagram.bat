apio raw "yosys -p \"read_verilog top_module.v; prep; show -colors 1 -width -stretch\" -q"
dot show.dot -Tsvg > diagram.svg

