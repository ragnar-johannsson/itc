# coding: utf-8

class MusicLibrary 
    attr_accessor :file, :tracks

    def initialize(file)
        @file = file
        @tracks = []

        parse_xml
    end

    def parse_xml
        in_tracks = false
        track = {}

        IO.foreach(File.expand_path(@file)) do |line|
            line = line.force_encoding("UTF-8")

            if line =~ /^\t<key>Tracks<\/key>$/
                in_tracks = true
                next
            end

            if in_tracks then
                if line =~ /^\t\t\t<key>(.*)<\/key><(date|integer|string)>(.*)<\/.*>$/
                    key = $1.downcase.split.join("_").intern
                    track[key] = $3.to_s
                    next
                elsif line =~ /^\t\t<\/dict>$/ then
                    @tracks.push(track.dup)
                    track.clear
                    next
                elsif in_tracks && line =~ /^\t<\/dict>$/
                    in_tracks = false
                    next
                else
                    next
                end
            end
        end
    end
end
