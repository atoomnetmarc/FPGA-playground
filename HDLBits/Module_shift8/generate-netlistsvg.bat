apio raw "yosys -p \"prep -top top_module; write_json netlist.json\" top_module.v my_dff8.v
netlistsvg netlist.json -o netlist.svg
