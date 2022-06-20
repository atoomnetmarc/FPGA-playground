apio raw "yosys -p \"prep -top top_module; write_json netlist.json\" top_module.v bcdcount.v
netlistsvg netlist.json -o netlist.svg
