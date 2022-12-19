class DepartmentPractitioner < ApplicationRecord
  belongs_to :department
  belongs_to :practitioner
end
