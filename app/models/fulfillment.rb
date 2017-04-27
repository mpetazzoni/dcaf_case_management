class Fulfillment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamp
  mongoid_userstamp user_model: 'User'

  # Relationships
  embedded_in :patient

  field :fulfilled, type: Boolean
  field :procedure_date, type: Date
  field :gestation_at_procedure, type: String
  field :procedure_cost, type: Integer
  field :check_number, type: String
  field :date_of_check, type: Date

  # Validations
  validates :created_by_id,
            presence: true
end
