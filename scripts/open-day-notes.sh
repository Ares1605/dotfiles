#!/bin/bash

cd "$HOME/Documents/notes"
mkdir "changelog"
nvim "changelog/$(date +%Y-%m-%d).md"
