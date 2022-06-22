apio raw "yosys -p \"read_verilog top_module.v; prep; show -colors 1 -width -stretch\" -q"
ccomps -o showsplit.dot show.dot
dot showsplit.dot -Tsvg > bcd24h2complex12h.svg
dot showsplit_1.dot -Tsvg > bcdcount24h.svg
dot showsplit_2.dot -Tsvg > diagram.svg
