#!/bin/bash
# Szmelc RGB - Razer Chroma Front End for polychromatic-cli

clear
echo "Szmelc RGB" | figlet | lolcat && echo ""
# Get the current user's username
USERNAME=$(whoami)

# Define the directory containing the effect scripts
EFFECTS_DIR="/home/${USERNAME}/.config/polychromatic/effects"

# Get a list of all effect script files in the effects directory
EFFECTS_LIST=$(ls "${EFFECTS_DIR}"/*.json | awk -F/ '{print $NF}' | sed 's/\.json$//' | sort)

# Prompt the user to set a time delay between effects in seconds
read -p "Enter the time delay between effects (in seconds): " DELAY

# Check if the entered delay is a positive number
if ! [[ "$DELAY" =~ ^[0-9]+$ ]] || [ "$DELAY" -lt 1 ]; then
  echo "Invalid input. Time delay must be a positive integer greater than 0."
  exit 1
fi

# Play effects one after another with the specified time delay
for EFFECT in $EFFECTS_LIST; do
  echo "Executing effect: ${EFFECT}"
  echo "${EFFECT}" | figlet | lolcat
  polychromatic-cli -e "${EFFECT}"
  sleep "$DELAY"
done

sleep 1 && clear
bash exec.sh
