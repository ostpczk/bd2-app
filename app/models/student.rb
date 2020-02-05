class Student < ActiveRecord::Base
  has_secure_password
  belongs_to :curriculum
  belongs_to :address
  accepts_nested_attributes_for :address

  before_create :create_remember_token
  before_create :create_address

  def Student.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Student.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = Student.digest(Student.new_remember_token)
    end

    def create_address
      new_address = Address.new(address)

      unless new_address.save
        self.errors.add(:base, "Couldn't create address.")
        return false
      end
      self.address_id = new_address.id
    end
end
