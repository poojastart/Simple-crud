class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :send_welcome_email
  has_one_attached :avatar
  has_many :products, dependent: :destroy
  validates :role, inclusion: { in: %w[owner customer] }
  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end