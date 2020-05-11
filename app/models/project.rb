class Project < ApplicationRecord
  belongs_to :user
  validates :name, :description, :start_date, :dead_line, presence: true
  has_one_attached :image

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships,dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :assignments, dependent: :destroy
end
