class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

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
