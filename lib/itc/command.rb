# coding: utf-8

class Command
    def self.execute(action, filters)
        db = Database.new
        player = Player.new
        xml = ENV["HOME"] + "/Music/iTunes/iTunes Music Library.xml"

        supported_filters = ("artist" "album" "song" "genre" "year")
        filters.keys.each do |filter|
            raise UnknownFilterException, filter unless supported_filters.include? filter
        end

        case action
        when "index"
            db.reindex MusicLibrary.new(xml)
        when "list"
            raise InvalidFilterNumberException, "No filter specified" if filters.empty?
            puts db.list(filters).collect { |f| f.last }
        when "play"
            player.play filters.empty? ? {} : db.list_ids(filters)
        when "pause"
            player.pause
        when "next"
            player.next
        when "previous", "prev"
            player.previous
        when "status"
            if player.state == "stopped"
                puts "iTunes is #{player.state}\n"
                return
            end

            curr_song = player.current_track
            state_icon = player.state == "playing" ? "▶" : "‖"
            playlist = player.current_playlist_tracks.split(", ")
            db.list_by_ids(playlist.size < 1000 ? playlist : [curr_song]).collect do |track|
                printf " %s %s - %s - %s\n", track[0].to_s == curr_song ? state_icon : " ",
                track[1], track[2], track[3]
            end
        else
            raise UnknownCommandException
        end
    end
end

class InvalidFilterNumberException < StandardError; end
class UnknownFilterException < StandardError; end
class UnknownCommandException < StandardError; end
