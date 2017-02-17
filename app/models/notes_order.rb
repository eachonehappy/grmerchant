class NotesOrder < ActiveRecord::Base
	belongs_to :order
	validates :description, presence: true
end
