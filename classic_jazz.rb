# Definition of songs
class Song
  attr_accessor :name, :artist, :genre, :subgenre, :tags

  def initialize(name, artist, genre, tags)
    @name = name
    @artist = artist
    @genre, @subgenre = genre.split(',').map(&:strip)
    @tags = tags.split(',') if tags
  end

  def matches?(criteria)
    criteria.all? do |key, value|
      case key
      when :name then name == value
      when :artist then artist == value
      when :genre then genre == value
      when :tags then tags.any? { |tag| tag == value }
      end
    end
  end
end

# Collection of songs
class Collection
  attr_reader :songs_objects

  def initialize(songs_objects)
    @songs_objects = songs_objects

    parse_collection
  end

  def split_in_songs
    songs_objects.lines.map do |line|
      line.split('.').map(&:strip)
    end
  end

  def parse_collection
    split_in_songs.map do |name, artist, genre, tags|
      Song.new(name, artist, genre, tags)
    end
  end

  def find(criteria)
    parse_collection.select { |song| song.matches?(criteria) }
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
