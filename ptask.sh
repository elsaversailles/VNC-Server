#!/bin/bash

# Setup color blocks
function show_progress_bar() {
  local step=$1
  local total=5
  local bar=""

  for ((i=1; i<=total; i++)); do
    if (( i <= step )); then
      bar+="\033[44m \033[0m"  # Blue
    else
      bar+="\033[47m \033[0m"  # Gray
    fi
  done

  echo -e "\nStep $step of $total:\n$bar\n"
}

# Check for dialog
command -v dialog >/dev/null 2>&1 || {
  echo "Installing dialog..."
  sudo apt install -y dialog > /dev/null 2>&1
}

# Create temp file
tempfile=$(mktemp 2>/dev/null)

# STEP 1
clear
show_progress_bar 1
dialog --backtitle "📁 Elsa's Setup Wizard" \
  --title "Step 1 of 5" \
  --no-cancel \
  --inputbox "Enter MAIN directory name:" 8 50 2> "$tempfile"
main_dir=$(<"$tempfile")
mkdir -p "$main_dir"

# STEP 2
clear
show_progress_bar 2
dialog --backtitle "📁 Elsa's Setup Wizard" \
  --title "Step 2 of 5" \
  --no-cancel \
  --inputbox "Enter SUBDIRECTORY name (inside $main_dir):" 8 50 2> "$tempfile"
sub_dir=$(<"$tempfile")
mkdir -p "$main_dir/$sub_dir"

# STEP 3
clear
show_progress_bar 3
dialog --backtitle "📁 Elsa's Setup Wizard" \
  --title "Step 3 of 5" \
  --no-cancel \
  --inputbox "Enter FILE name (e.g., grades.dat):" 8 50 2> "$tempfile"
file_name=$(<"$tempfile")
touch "$main_dir/$sub_dir/$file_name"
chmod 755 "$main_dir/$sub_dir/$file_name"

# STEP 4
clear
show_progress_bar 4
dialog --backtitle "📁 Elsa's Setup Wizard" \
  --title "Step 4 of 5" \
  --infobox "Installing 'tree' package (silently)..." 5 50
sudo apt install -y tree > /dev/null 2>&1
sleep 1

# STEP 5
tree "$main_dir" > "$tempfile"
dialog --backtitle "📁 Elsa's Setup Wizard" \
  --title "✅ Final Step: Structure Preview" \
  --textbox "$tempfile" 20 60


# CLEANUP
rm -f "$tempfile"
clear
