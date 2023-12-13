# == Schema Information
# Schema version: 20231213093301
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  books_count            :integer
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  words_count            :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  has_many :books, dependent: :destroy
  has_many :words, through: :books
  broadcasts_refreshes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:login]

  validates :email, uniqueness: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validate :validate_username
  attr_writer :login

  def login
    @login || username || email
  end

  def validate_username
    return unless User.where(email: username).exists?
      errors.add(:username, :invalid)
    
  end

  def downcase_fields
    username.downcase!
    email.downcase!
  end


  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["username = :value OR email = :value", { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end
