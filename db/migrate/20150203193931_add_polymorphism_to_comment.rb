class AddPolymorphismToComment < ActiveRecord::Migration
  def change
  	add_column :comments, :commentable_id, :integer #in direct migration, could also just do t.references :commentable, polymorphic: true, index :true
    add_column :comments, :commentable_type, :string
    remove_column :comments, :link_id, :integer
  end
end
