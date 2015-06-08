class Project < ActiveRecord::Base
  after_create :create_new_project, :create_first_card
  belongs_to :user
  has_many :cards, -> { order("position ASC") }, dependent: :destroy

  def create_first_card
  	Card.create(project: self)
  end

  def create_new_project
  	Project.update(user: self, title: "Enter a title here")
  end
end
