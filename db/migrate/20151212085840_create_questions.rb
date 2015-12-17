class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :body  
      t.timestamps null: false
      t.belongs_to :user, index: true
    end
  end
end
