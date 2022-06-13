apio raw "yosys -p \"prep -top top_module; write_json netlist.json\" top_module.v add16.v
netlistsvg netlist.json -o netlist.svg
