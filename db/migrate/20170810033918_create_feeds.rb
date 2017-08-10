# frozen_string_literal: true

class CreateFeeds < ActiveRecord::Migration[5.1]

  def change
    create_table :feeds do |t|
      t.string :username
      t.jsonb :payload

      t.timestamps
    end
  end

end
