tell application "System Events"
	set names to name of application processes
  set activeApp to name of first application process whose frontmost is true
	if names contains "kitty" then
		tell application process "kitty"
			if visible then
        if "kitty" is in activeApp then
				  set visible to false
        else
				  tell application "kitty" to activate
        end if
			else
				# use the following to simply have it reappear:
				set visible to true
				# use the following to focus Safari:
				tell application "kitty" to activate
			end if
		end tell
	else
    set runKitty to do shell script "whoami | xargs -I {} kitty --single-instance --directory=/Users/{}"
	end if
end tell
