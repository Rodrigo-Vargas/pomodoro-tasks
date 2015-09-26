class Task < ActiveRecord::Base
  belongs_to :project

  def done
  end

  def isCompleted
    if self.completed_at != nil
      true
    else
      false
    end
  end
end
