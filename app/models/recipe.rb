class Recipe < ActiveRecord::Base
  has_many :users, through: :cart_recipes
  has_many :cart_recipes
  has_many :orders, through: :order_recipes
  has_many :order_recipes
  validates :sku, presence: true, uniqueness: true
	validates :name, presence: true
	validates :price, presence: true,:numericality => true
	validates :serving, presence: true,:numericality => true

 def self.import(file)
  spreadsheet = Roo::Spreadsheet.open(file.path)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    recipe = find_by(id: row["id"]) || new
    recipe.attributes = row.to_hash
    recipe.save!
  end
end	

end
