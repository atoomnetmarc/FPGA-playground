apio raw "yosys -p \"prep -top top_module; write_json netlist.json\" top_module.v
call netlistsvg netlist.json -o netlist-top_module.svg

apio raw "yosys -p \"prep -top fsm_next_state; write_json netlist.json\" top_module.v
call netlistsvg netlist.json -o netlist-fsm_next_state.svg

apio raw "yosys -p \"prep -top fsm_state_transition; write_json netlist.json\" top_module.v
call netlistsvg netlist.json -o netlist-fsm_state_transition.svg

apio raw "yosys -p \"prep -top fsm_output; write_json netlist.json\" top_module.v
call netlistsvg netlist.json -o netlist-fsm_output.svg
