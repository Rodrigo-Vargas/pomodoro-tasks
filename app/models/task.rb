class Task < ActiveRecord::Base
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
