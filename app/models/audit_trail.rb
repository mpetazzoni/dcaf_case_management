# Keeps track of the history of objects (mostly patients and pregnancies).
class AuditTrail
  include Mongoid::History::Tracker
  include Mongoid::Userstamp
  mongoid_userstamp user_model: 'User'

  IRRELEVANT_FIELDS = %w(user_ids updated_by_id identifier).freeze

  @changed = nil

  # convenience methods for clean view display
  def date_of_change
    created_at.display_timestamp
  end

  def changed_fields
    @changed ||= modified.select do |key, value|
      if IRRELEVANT_FIELDS.include?(key) || (!original.keys.include?(key) && value == '')
        false
      else
        original[key] != value
      end
    end.keys
  end

  def changed_by_user
    created_by ? created_by.name : 'System'
  end

  def marked_urgent?
    modified.include?('urgent_flag') && modified['urgent_flag'] == true
  end
end
