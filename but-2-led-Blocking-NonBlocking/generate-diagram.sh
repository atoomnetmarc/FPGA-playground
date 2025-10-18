#!/bin/bash
apio raw "yosys -p \"read_verilog top.v; prep; show -format dot -prefix show -viewer none -colors 1 -width -stretch\" -q" &&
ccomps -o showsplit.dot show.dot &&
dot showsplit.dot -Tsvg > blocking.svg &&
dot showsplit_1.dot -Tsvg > nonblocking.svg &&
dot showsplit_2.dot -Tsvg > diagram.svg
