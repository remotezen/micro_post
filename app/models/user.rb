class User < ApplicationRecord

  attr_accessor :remember_token

  before_save {self.email = email.downcase }
  before_save {self.username = username.downcase }
  validates :name, presence: true, length:{maximum: 50}

  validates :username, presence: true, length:{maximum:50},
                       uniqueness:{case_sensitive: false}


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length:{maximum:255},
                              format:{with: VALID_EMAIL_REGEX},
                              uniqueness:{case_sensitive:false}
  has_secure_password
  validates :password, presence: true, length:{minimum:6}
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)

  end
  def self.username_or_email(credential)
    if VALID_EMAIL_REGEX.match(credential)
      user = User.find_by(email: credential)
    else
      user = User.find_by( username: credential )
    end
    return user
  end
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
