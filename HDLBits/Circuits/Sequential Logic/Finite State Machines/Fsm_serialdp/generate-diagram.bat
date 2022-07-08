apio raw "yosys -p \"read_verilog top_module.v; prep; show -colors 1 -width -stretch\" -q"
ccomps -o showsplit.dot show.dot
dot showsplit.dot -Tsvg > diagram-fsm_next_state.svg
dot showsplit_1.dot -Tsvg > diagram-fsm_output.svg
dot showsplit_2.dot -Tsvg > diagram-fsm_state_transition.svg
dot showsplit_3.dot -Tsvg > diagram-top_module.svg
