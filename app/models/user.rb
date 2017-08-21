class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :polls
  has_many :belongings
  has_many :answers
  validates :first_name, :last_name, presence: true
  has_attachment :photo

end