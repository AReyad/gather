module EventValidations
  MIN_TITLE_LENGTH = 10
  MAX_TITLE_LENGTH = 50
  MIN_DESCRIPTION_LENGTH = 50
  MAX_DESCRIPTION_LENGTH = 500
  MIN_LOCATION_LENGTH = 4
  MAX_LOCATION_LENGTH = 30

  def self.min_date
    Date.today + 1.day
  end

  def self.max_date
    80.years.from_now.to_date
  end
end
