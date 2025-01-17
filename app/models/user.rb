class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


         has_many :memberships,dependent: :destroy
         has_many :projects, through: :memberships,dependent: :destroy
         has_many :requests, dependent: :destroy
         has_many :assignments, dependent: :destroy
         validates :company_name,:first_name,:last_name,:rank, presence: true


end
