apio raw "yosys -p \"read_verilog top_module.v; read_verilog count4.v; prep; show -colors 1 -width -stretch\" -q"
ccomps -o showsplit.dot show.dot
dot showsplit.dot -Tsvg > count4.svg
dot showsplit_1.dot -Tsvg > diagram.svg

apio raw "yosys -p \"read_verilog top_module.v; read_verilog count4.v; synth_ice40; show -colors 1 -width -stretch\" -q"
dot show.dot -Tsvg > diagram-ice40.svg
