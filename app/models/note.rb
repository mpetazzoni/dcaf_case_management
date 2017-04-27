# Object representing a case manager's log of their interactions with a patient.
class Note
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamp
  mongoid_userstamp user_model: 'User'

  # Relationships
  embedded_in :patient

  # Fields
  field :full_text, type: String

  # Validations
  validates :created_by_id, :full_text, presence: true
end
