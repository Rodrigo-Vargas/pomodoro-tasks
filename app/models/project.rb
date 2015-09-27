class Project < ActiveRecord::Base
  has_many :tasks

  def is_show_in_dashboard
    if self.show_in_dashboard
      true
    else
      false
    end
  end
end
