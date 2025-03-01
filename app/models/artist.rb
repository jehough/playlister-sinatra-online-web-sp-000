class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

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
