# coding: utf-8

require "sqlite3"

class Database
    def initialize
        @db = SQLite3::Database.new(ENV["HOME"] + "/.itc.db")
    end

    def reset
        @db.execute_batch <<-SQL
            drop index if exists tracks_artist_index;
            drop index if exists tracks_album_index;
            drop index if exists tracks_song_index;
            drop index if exists tracks_genre_index;
            drop index if exists tracks_year_index;
            drop table if exists tracks;

            create table tracks (
                track_id        INTEGER PRIMARY KEY,
                artist          VARCHAR DEFAULT NULL,
                album           VARCHAR DEFAULT NULL,
                song            VARCHAR DEFAULT NULL,
                genre           VARCHAR DEFAULT NULL,
                year            VARCHAR DEFAULT NULL,
                disc_number     INTEGER DEFAULT NULL,
                track_number    INTEGER DEFAULT NULL
            );

            create index tracks_artist_index on tracks (artist);
            create index tracks_album_index on tracks (album);
            create index tracks_song_index on tracks (song);
            create index tracks_genre_index on tracks (genre);
            create index tracks_year_index on tracks (year);
        SQL
    end

    def add_tracks(tracks)
        @db.transaction do |db|
            db.prepare("insert into tracks values (?, ?, ?, ?, ?, ?, ?, ?)") do |stmt|
                tracks.each do |t|
                    stmt.execute t[:track_id].to_i, t[:artist], t[:album], t[:name],
                    t[:genre], t[:year], t[:disc_number].to_i, t[:track_number].to_i
                end
            end
        end
    end

    def reindex(music)
        reset
        add_tracks music.tracks
    end

    def list(filters)
        c = filters.keys.collect { |k| "#{k} like \"%#{filters[k]}%\"" }
        condition = c.empty? ? "" : "where #{c.join(' and ')}"
        fields = filters.keys.join(",")
        @db.execute <<-SQL
            select distinct #{fields} from tracks #{condition} order by artist, album, disc_number, track_number
        SQL
    end

    def list_ids(filters)
        c = filters.keys.collect { |k| "#{k} like \"%#{filters[k]}%\"" }
        condition = c.empty? ? "" : "where #{c.join(' and ')}"
        @db.execute <<-SQL
            select track_id from tracks #{condition} order by artist, album, disc_number, track_number
        SQL
    end
end
