apio raw "yosys -p \"prep -top top_module; aigmap; write_json aig.json\" top_module.v my_dff8.v
netlistsvg aig.json -o aig.svg
