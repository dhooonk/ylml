class User < ApplicationRecord
  require 'csv'
  attr_accessor :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      User.create! row.to_hash
    end
  end

  has_one :cabinet, :dependent => :destroy
  has_one :cabinetApliSci, :dependent => :destroy
  has_one :cabinetIme, :dependent => :destroy
  has_one :cabinetEni, :dependent => :destroy

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(stuN) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:stuN) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end

  validates_format_of :stuN, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  def email_required?
    false
  end
end
