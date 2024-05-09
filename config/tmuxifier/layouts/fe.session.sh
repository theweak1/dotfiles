# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
#session_root "~/Projects/js"
session_root "$(pwd)"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "fe"; then

  # Create a new window for editing files in Neovim.
  new_window "editor"
  run_cmd "nvim"
  
  # Create a new window for running frontend and backend servers.
  new_window "servers"
  run_cmd "npm run dev"
  # Select the default active window on session creation.
  select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
