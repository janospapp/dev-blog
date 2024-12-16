class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :summary
      t.text :body
      t.datetime :published_at, null: true, default: nil, index: true
      t.datetime :body_updated_at, null: true, default: nil
      t.integer :visitor_count, null: false, default: 0
      t.string :ref, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
