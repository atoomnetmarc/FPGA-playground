#!/bin/bash
apio raw "yosys -p \"prep -top top; write_json netlist.json\" top.v -q" &&
netlistsvg netlist.json -o netlist.svg
