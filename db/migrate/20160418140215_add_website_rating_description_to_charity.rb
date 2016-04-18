class AddWebsiteRatingDescriptionToCharity < ActiveRecord::Migration
  def change
    add_column :charities, :rating, :string
    add_column :charities, :description, :string
    add_column :charities, :website, :string
    add_column :charities, :address, :string
  end
end
