class LibraryParser
  def files
    data_path = File.join(File.dirname(__FILE__), '..', 'db', 'data')
    Dir.entries(data_path)[2..-1]
  end

  def self.parse
    self.new.call
  end

  def parse_filename(filename)
    filearr = filename.split(/ - |\[|\]./)
    filearr.pop
    filearr
  end

  def call
    files.each do |filename|
      parts = parse_filename(filename)
      build_objects(*parts)
    end
  end

  def build_objects(artist_name, song_name, genre_name)
    song = Song.create(name: song_name)
    genre = Genre.find_or_create_by(name: genre_name)
    artist = Artist.find_or_create_by(name: artist_name)

    SongGenre.create(:song_id => song.id, :genre_id => genre.id)
    song.artist = artist

    song.save
  end
end
