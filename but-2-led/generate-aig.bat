apio raw "yosys -p \"prep -top top; aigmap; write_json aig.json\" top.v
netlistsvg aig.json -o aig.svg
