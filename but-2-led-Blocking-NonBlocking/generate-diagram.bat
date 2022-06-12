apio raw "yosys -p \"read_verilog top.v; show\" -q"
gvpack -u show.dot > show-combined.dot
dot show-combined.dot -Tsvg > diagram.svg
