class WorkingHour < ApplicationRecord
    belongs_to :artist

    attr_accessor :not_working, :holiday
end
