apio raw "yosys -p \"read_verilog top_module.v; prep; show -colors 1 -width -stretch\" -q"
dot show.dot -Tsvg > diagram.svg

ccomps -o showsplit.dot show.dot
dot showsplit.dot -Tsvg > add1.svg
dot showsplit_1.dot -Tsvg > diagram.svg
