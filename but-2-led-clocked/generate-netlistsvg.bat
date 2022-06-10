apio raw "yosys -p \"prep -top top; write_json netlist.json\" top.v
netlistsvg netlist.json -o netlist.svg
