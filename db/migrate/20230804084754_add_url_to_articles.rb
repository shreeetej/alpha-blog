class AddUrlToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles , :URL , :text
    add_column :articles , :created_by , :string
  end
end
