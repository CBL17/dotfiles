#!/bin/bash

FAINT_PURPLE='\[\033[38;5;105m\]'
WATER_BLUE='\[\033[38;5;69m\]'
VIBRANT_PURPLE='\[\033[38;5;141m\]'
PS_CLEAR='\[\033[0m\]'

ACTIVE_BRANCH=$(git branch --show-current 2>/dev/null)
PS1="${FAINT_PURPLE}\u${WATER_BLUE}@${FAINT_PURPLE}\h  ${VIBRANT_PURPLE}\W/  ${WATER_BLUE}(${ACTIVE_BRANCH}) ${PS_CLEAR}\$ "
