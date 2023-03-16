class AddUserIdToApiKey < ActiveRecord::Migration[7.0]
  def change
    add_reference :api_keys, :user, null: false, foreign_key: true
  end
end
