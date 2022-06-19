apio raw "yosys -p \"prep -top top_module; write_json netlist.json\" top_module.v count4.v
netlistsvg netlist.json -o netlist.svg
