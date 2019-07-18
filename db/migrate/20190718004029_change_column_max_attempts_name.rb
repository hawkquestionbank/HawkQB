class ChangeColumnMaxAttemptsName < ActiveRecord::Migration[5.2]
  def change
    rename_column :courses, :max_attemps, :max_attempts
  end
end
