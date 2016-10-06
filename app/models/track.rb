class Track < ActiveRecord::Base
  validates :album_id, :track_type, presence: true
  validates :track_type, inclusion: {in: ["regular","bonus"]}

  belongs_to :album

  has_many :notes
end
