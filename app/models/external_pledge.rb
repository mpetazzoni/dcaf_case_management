# Object representing money from outside organizations.
# For DCAF pledges or NNAF pledges, see the pregnancy model.
class ExternalPledge
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamp
  mongoid_userstamp user_model: 'User'

  # Relationships
  embedded_in :patient

  default_scope -> { where(active: true) }
  scope :active, -> { where(active: true) }

  # Fields
  field :source, type: String # Name of outside organization or fund
  field :amount, type: Integer
  field :active, type: Boolean, default: true

  # Validations
  validates :created_by_id, :source, :amount, presence: true
  validates :source, uniqueness: { scope: :active }
end
