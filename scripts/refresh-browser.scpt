set hostname to "localhost"

tell application "System Events"
    set needToStartSafari to (count of (every process whose bundle identifier is "com.apple.safari")) is 0
end tell

tell application "Safari"
    if (count of (every tab of every window whose URL contains hostname)) is 0
        open location "http://localhost:4000"
    else
        tell every tab of every window whose URL contains hostname to open location (get its URL)
    end if
end tell
