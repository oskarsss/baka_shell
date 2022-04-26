#!/bin/bash

source ./get_answer.sh #getting yes or no answers
source ./firewalld_setup.sh #setting up firewalld

echo "Do you want to configure firewalld? If you are using stationary PC with ethernet, there is little meaning to this procedure"
confirm && Firewalld_initial_setup
