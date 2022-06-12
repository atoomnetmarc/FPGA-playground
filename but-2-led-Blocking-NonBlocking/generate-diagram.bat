apio raw "yosys -p \"read_verilog top.v; show -colors 1 -width -stretch\" -q"
gvpack -u show.dot > show-combined.dot
dot show-combined.dot -Tsvg > diagram.svg
