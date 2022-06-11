apio raw "yosys -p \"read_verilog top_module.v; show -stretch\" -q"
gvpack -u show.dot > show-combined.dot
dot show-combined.dot -Tsvg > diagram.svg

apio raw "yosys -p \"read_verilog add16.v; show -stretch\" -q"
dot show.dot -Tsvg > add16.svg
