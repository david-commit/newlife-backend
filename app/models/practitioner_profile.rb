class PractitionerProfile < ApplicationRecord
  belongs_to :practitioner

  validates :practitioner_id, uniqueness: true

  include PgSearch::Model

  pg_search_scope :search_by_name,
                  against: %i[first_name last_name],
                  using: {
                    tsearch: {
                      prefix: true
                    }
                  }
end
