# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null

# FIGVAPER
class User < ApplicationRecord
  validates :username, :session_token ,presence: true, uniqueness: true
  validates :password, length:{minimum:6, allow_nil:true}
  validates :password_digest, presence:true

  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username, password: password)
    if user && is_password?(password)
      user
    else
      nil
    end
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
