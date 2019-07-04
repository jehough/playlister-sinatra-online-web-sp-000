class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  def slug
    self.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug)
    full_name = nil
    self.all.each do |obj|
      if obj.slug == slug
        full_name = obj
      end
    end
    full_name
  end
end
