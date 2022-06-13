apio raw "yosys -p \"read_verilog top_module.v; read_verilog add16.v; prep; show -colors 1 -width -stretch\" -q"
ccomps -o showsplit.dot show.dot
dot showsplit_1.dot -Tsvg > diagram.svg

apio raw "yosys -p \"read_verilog add16.v; prep; show -colors 1 -width -stretch\" -q"
dot show.dot -Tsvg > add16.svg
