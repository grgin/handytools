#!/bin/bash

sudo find . -type d -name "bin" -exec rm -rf {} +
sudo find . -type d -name "obj" -exec rm -rf {} +
