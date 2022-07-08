apio raw "yosys -p \"prep -top top_module; aigmap; write_json aig.json\" top_module.v
call netlistsvg aig.json -o aig-top_module.svg

apio raw "yosys -p \"prep -top fsm_next_state; aigmap; write_json aig.json\" top_module.v
call netlistsvg aig.json -o aig-fsm_next_state.svg

apio raw "yosys -p \"prep -top fsm_state_transition; aigmap; write_json aig.json\" top_module.v
call netlistsvg aig.json -o aig-fsm_state_transition.svg

apio raw "yosys -p \"prep -top fsm_output; aigmap; write_json aig.json\" top_module.v
call netlistsvg aig.json -o aig-fsm_output.svg
