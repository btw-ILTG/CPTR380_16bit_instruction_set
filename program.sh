#!/bin/bash
djtgcfg init -d JtagHs2 --verbose
djtgcfg prog -f instruction_set.bit -d JtagHs2 -i 0
