# coding: utf-8

class Player
    def execute(script)
        `osascript -e '#{script}'`
    end

    def play(tracks)
        if tracks.empty?
            execute 'tell application "iTunes" to play'
        else 
            tracks = tracks.collect {|track| "database ID is #{track}"}
            execute <<-SCRIPT
                set pName to "itc"
                tell application "iTunes"
                    if not ((name of playlists) contains pName) then
                        set itcPlaylist to make new playlist with properties {name:pName}
                    else
                        set itcPlaylist to playlist pName
                        delete every track of itcPlaylist
                    end if

                    duplicate (every track whose #{
                        tracks.join(" or ")
                    }) to itcPlaylist

                    play itcPlaylist
                end tell
            SCRIPT
        end
    end

    def pause
        execute 'tell application "iTunes" to pause'
    end

    def next
        execute 'tell application "iTunes" to next track'
    end

    def previous 
        execute 'tell application "iTunes" to previous track'
    end
end
