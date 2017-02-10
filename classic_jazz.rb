# Definition of songs
class Song
  attr_accessor :name, :artist, :genre, :subgenre, :tags

  def initialize(name, artist, genre, tags)
    @name = name
    @artist = artist
    @genre, @subgenre = genre.split(',').map(&:strip)
    @tags = tags
  end

  def self.get_data(data, artist_tags)
    data[3] = '' if data[3].nil?
    artist_tags.default = []
    genre_tags = data[2].split(', ').map(&:downcase)

    {
      name: data[0],
      artist: data[1],
      genre: data[2],
      tags: (data[3].split(', ') + genre_tags + artist_tags[data[1]])
    }
  end

  def self.parse(songs_objects, artist_tags)
    parsed_data = get_data(songs_objects, artist_tags)

    name = parsed_data[:name]
    artist = parsed_data[:artist]
    genre = parsed_data[:genre]
    tags = parsed_data[:tags]

    new(name, artist, genre, tags)
  end

  def matches?(criteria)
    criteria.all? do |key, value|
      case key
      when :name then name == value
      when :artist then artist == value
      when :genre then genre == value
      when :tags then matches_tags?(value)
      when :filter then value.call(self)
      end
    end
  end

  def matches_tags?(criteria_tags)
    criteria_tags = [criteria_tags] if criteria_tags.is_a?(String)

    criteria_tags.all? do |criteria_tag|
      if criteria_tag.end_with?('!')
        tags.none? { |tag| criteria_tag[0...-1] == tag }
      else
        tags.any? { |tag| criteria_tag == tag }
      end
    end
  end
end

# Collection of songs
class Collection
  attr_reader :songs_objects, :artist_tags, :parsed_collection

  def initialize(songs_objects, artist_tags)
    @songs_objects = songs_objects
    @artist_tags = artist_tags
    @parsed_collection = parse_collection
  end

  def split_in_songs
    songs_objects.lines.map do |line|
      line.split('.').map(&:strip)
    end
  end

  def parse_collection
    split_in_songs.map do |data|
      Song.parse(data, artist_tags)
    end
  end

  def find(criteria)
    parsed_collection.select { |song| song.matches?(criteria) }
  end
end

# songs =
# "My Favourite Things.   John Coltrane.   Jazz, Bebop.        popular, cover
#   Greensleves.            John Coltrane.   Jazz, Bebop.        popular, cover
#   Alabama.                John Coltrane.   Jazz, Avantgarde.   melancholic
#   Acknowledgement.        John Coltrane.   Jazz, Avantgarde
#   Afro Blue.              John Coltrane.   Jazz.               melancholic
#   'Round Midnight.        John Coltrane.   Jazz
#   My Funny Valentine.         Miles Davis.   Jazz.               popular
#   Tutu.                       Miles Davis.   Jazz, Fusion.       weird, cool
#   Miles Runs the Voodoo Down. Miles Davis.   Jazz, Fusion.       weird
#   Boplicity.                  Miles Davis.   Jazz, Bebop
#   Autumn Leaves.          Bill Evans.   Jazz.               popular
#   Waltz for Debbie.       Bill Evans.   Jazz
#   'Round Midnight.        Thelonious Monk.   Jazz, Bebop
#   Ruby, My Dear.          Thelonious Monk.   Jazz.               saxophone
#   Fur Elise.              Beethoven.    Classical.          popular
#   Moonlight Sonata.       Beethoven.    Classical.          popular
#   Pathetique.             Beethoven.    Classical
#   Toccata e Fuga.         Bach.         Classical, Baroque. popular
#   Goldberg Variations.    Bach.         Classical, Baroque
#   Eine Kleine Nachtmusik. Mozart.       Classical.          popular, violin"

# hashss = {
#   'John Coltrane' => %w[saxophone],
#   'Bach' => %w[piano polyphony],
# }
