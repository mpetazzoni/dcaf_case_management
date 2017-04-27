# Object representing a case manager dialing a patient.
class Call
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamp
  mongoid_userstamp user_model: 'User'

  # Relationships
  embedded_in :patient

  # Fields
  field :status, type: String

  # Validations
  allowed_statuses = ['Reached patient',
                      'Left voicemail',
                      "Couldn't reach patient"]
  validates :status,  presence: true,
                      inclusion: { in: allowed_statuses }
  validates :created_by_id, presence: true

  def recent?
    updated_at > 8.hours.ago ? true : false
  end

  def reached?
    status == 'Reached patient'
  end
end
