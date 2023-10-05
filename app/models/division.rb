class Division < ApplicationRecord
  enum title: {
    "A" => 0, 
    "B" => 1
  }

  has_many :teams, dependent: :nullify

  validates :title, inclusion: titles.keys, uniqueness: true

  def process
  end
end
