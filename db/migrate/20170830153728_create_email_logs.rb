class CreateEmailLogs < ActiveRecord::Migration
  def change
    create_table :email_logs do |t|
      t.string :name
      t.string :type_message
      t.string :status
      t.text :message

      t.timestamps null: false
    end
  end
end
