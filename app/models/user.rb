class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  validates :email, uniqueness: true
  # validates :profile, presence: true

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  # before_create :assign_role

  # def assign_role
  #   self.add_role :user if self.roles.first.nil?
  # end

end
