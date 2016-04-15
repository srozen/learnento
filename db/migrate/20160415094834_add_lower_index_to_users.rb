class AddLowerIndexToUsers < ActiveRecord::Migration
  def change
    execute %{ CREATE INDEX
        users_lower_last_name
      ON
        users (lower(last_name) varchar_pattern_ops)
    }
    execute %{ CREATE INDEX
        users_lower_first_name
      ON
        users (lower(first_name) varchar_pattern_ops)
    }
  end
end