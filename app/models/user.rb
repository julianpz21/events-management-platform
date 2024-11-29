class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
    :timeoutable

  has_many :events, dependent: :destroy

  enum role: { user: 0, admin: 1 }
end
