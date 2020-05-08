#!/bin/bash
# A menu driven shell script sample template 
## ----------------------------------
# Step #1: Define variables
# ----------------------------------
EDITOR=vim
PASSWD=/etc/passwd
GREEN='\033[0;32m'
BLUE='\033[0;34m'
STD='\033[0;0;39m'
NC='\033[0m' # No Color
 
# ----------------------------------
# Step #2: User defined function
# ----------------------------------
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

pre-prod(){
    OUTPUTBLUE="$(aws ec2 describe-instances --region=us-west-2 --filters  "Name=tag-value,Values=Worker" "Name=tag-value,Values=AutoScaleWorkerBlue" | jq '.Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddress')"
    OUTPUTGREEN="$(aws ec2 describe-instances --region=us-west-2 --filters  "Name=tag-value,Values=Worker" "Name=tag-value,Values=AutoScaleWorkerGreen" | jq '.Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddress')"
    echo "Checking for Autoscale Green"
    echo "*********************"
    if [ -z "$OUTPUTGREEN" ]; then
        echo -e "${GREEN}No AutoscaleWorkers Green${NC} "
        echo 
    else
        echo -e "${GREEN}Found AutoscaleWorkers Green${NC} "
        echo "*********************"
        echo -e "${GREEN}${OUTPUTGREEN}${NC}"
    fi
    echo "Checking for Autoscale Blue"
    echo "*********************"
    echo 
    if [ -z "$OUTPUTBLUE" ]; then
        echo -e "${BLUE}No AutoscaleWorkers Blue${NC} "
    else 
        echo -e "${BLUE}Found AutoscaleWorkers Blue${NC} "
        echo "*********************"
        echo -e "${BLUE}${OUTPUTBLUE}${NC}"
        echo 
    fi
    pause
}
 
# do something in two()
pre-prod2(){
    OUTPUTBLUE="$(aws ec2 describe-instances --region=us-west-2 --filters  "Name=tag-value,Values=Worker" "Name=tag-value,Values=AutoScaleWorkerBlue" | jq '.Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddress')"
    OUTPUTGREEN="$(aws ec2 describe-instances --region=us-west-2 --filters  "Name=tag-value,Values=Worker" "Name=tag-value,Values=AutoScaleWorkerGreen" | jq '.Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddress')"
    echo "Checking for Autoscale Green"
    echo "*********************"
    if [ -z "$OUTPUTGREEN" ]; then
        echo -e "${GREEN}No AutoscaleWorkers Green${NC} "
        echo 
    else
        echo -e "${GREEN}Found AutoscaleWorkers Green${NC} "
        echo "*********************"
        echo -e "${GREEN}${OUTPUTGREEN}${NC}"
    fi
    echo "Checking for Autoscale Blue"
    echo "*********************"
    echo 
    if [ -z "$OUTPUTBLUE" ]; then
        echo -e "${BLUE}No AutoscaleWorkers Blue${NC} "
    else 
        echo -e "${BLUE}Found AutoscaleWorkers Blue${NC} "
        echo "*********************"
        echo -e "${BLUE}${OUTPUTBLUE}${NC}"
        echo 
    fi
    pause
}

# do something in three()

mtl-cust(){
    OUTPUTBLUE="$(aws ec2 describe-instances --region=ca-central-1 --filters  "Name=tag-key,Values=Name" "Name=tag-value,Values=bigip01-prod.services.wd" | jq '.Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddress')"
    OUTPUTGREEN="$(aws ec2 describe-instances --region=ca-central-1 --filters  "Name=tag-value,Values=Worker" "Name=tag-value,Values=AutoScaleWorkerGreen" | jq '.Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddress')"
    echo "Checking for Autoscale Green"
    echo "*********************"
    if [ -z "$OUTPUTGREEN" ]; then
        echo -e "${GREEN}No AutoscaleWorkers Green${NC} "
        echo 
    else
        echo -e "${GREEN}Found AutoscaleWorkers Green${NC} "
        echo "*********************"
        echo -e "${GREEN}${OUTPUTGREEN}${NC}"
    fi
    echo "Checking for Autoscale Blue"
    echo "*********************"
    echo 
    if [ -z "$OUTPUTBLUE" ]; then
        echo -e "${BLUE}No AutoscaleWorkers Blue${NC} "
    else 
        echo -e "${BLUE}Found AutoscaleWorkers Blue${NC} "
        echo "*********************"
        echo -e "${BLUE}${OUTPUTBLUE}${NC}"
        echo 
    fi
    pause
}


# do something in four()

ore-cust(){
    OUTPUTBLUE="$(aws ec2 describe-instances --region=us-west-2 --filters  "Name=tag-value,Values=Worker" "Name=tag-value,Values=AutoScaleWorkerBlue" | jq '.Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddress')"
    OUTPUTGREEN="$(aws ec2 describe-instances --region=us-west-2 --filters  "Name=tag-value,Values=Worker" "Name=tag-value,Values=AutoScaleWorkerGreen" | jq '.Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddress')"
    echo "Checking for Autoscale Green"
    echo "*********************"
    if [ -z "$OUTPUTGREEN" ]; then
        echo -e "${GREEN}No AutoscaleWorkers Green${NC} "
        echo 
    else
        echo -e "${GREEN}Found AutoscaleWorkers Green${NC} "
        echo "*********************"
        echo -e "${GREEN}${OUTPUTGREEN}${NC}"
    fi
    echo "Checking for Autoscale Blue"
    echo "*********************"
    echo 
    if [ -z "$OUTPUTBLUE" ]; then
        echo -e "${BLUE}No AutoscaleWorkers Blue${NC} "
    else 
        echo -e "${BLUE}Found AutoscaleWorkers Blue${NC} "
        echo "*********************"
        echo -e "${BLUE}${OUTPUTBLUE}${NC}"
        echo 
    fi
    pause
}
 
 
# function to display menus
show_menus() {
    clear
    echo "~~~~~~~~~~~~~~~~~~~~~"    
    echo " M A I N - M E N U"
    echo "~~~~~~~~~~~~~~~~~~~~~"
    echo "1. pre-prod us-west-2"
    echo "2. pre-prod2 us-west-2"
    echo "3. mtl-cust ca-central1"
    echo "4. ore-cust us-west-2"
    echo "5. Exit"
}
# read input from the keyboard and take a action
# invoke the one() when the user select 1 from the menu option.
# invoke the two() when the user select 2 from the menu option.
# Exit when user the user select 3 form the menu option.
read_options(){
    local choice
    read -p "Enter choice [ 1 - 5 ] " choice
    case $choice in
        1) pre-prod ;;
        2) pre-prod2 ;;
        3) mtl-cust ;;
        4) ore-cust ;;
        5) exit 0;;
        *) echo -e "${RED}Error...${STD}" && sleep 2
    esac
}
 
# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP
 
# -----------------------------------
# Step #4: Main logic - infinite loop
# ------------------------------------
while true
do
 
    show_menus
    read_options
done