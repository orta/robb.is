set tabName to "Robb is"

tell application "System Events"
    set isChromeRunning to (count of (every process whose bundle identifier is "com.google.chrome")) > 0
    set isSafariRunning to (count of (every process whose bundle identifier is "com.apple.safari")) > 0
end tell

if isChromeRunning
    tell application "Google Chrome" to tell every tab of every window whose title contains tabName
        reload
    end tell
end if

if isSafariRunning
    tell application "Safari" to tell every tab of every window whose name contains tabName
        open location (get its URL)
    end tell
end if
