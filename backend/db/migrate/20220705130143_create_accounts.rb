class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.bigint :number
      t.bigint :initial_balance

      t.timestamps
    end
  end
end
