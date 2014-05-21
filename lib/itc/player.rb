# coding: utf-8

class Player
    def execute(script)
        `osascript -e '#{script}'`.gsub(/\n$/, "")
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

    def state
        execute 'tell application "iTunes" to return player state'
    end

    def current_track
        execute 'tell application "iTunes" to return database ID of current track'
    end

    def current_playlist_tracks
        execute <<-SCRIPT
            tell application "iTunes"
                return database ID of tracks of current playlist
            end tell
        SCRIPT
    end
end
