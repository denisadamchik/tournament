module Divisionable
  extend ActiveSupport::Concern

  included do
    enum division: {
      "A" => 0,
      "B" => 1
    }

    validates :division, inclusion: { in: divisions.keys }, allow_nil: true
  end
end
