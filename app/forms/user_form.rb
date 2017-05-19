class UserForm
  
  include ActiveModel::Model
  include Virtus.model

  STRING_ATTRS = [:first_name, :last_name, :address, :phone, :city, :country, :shipping_first_name, :shipping_last_name, :shipping_address, :shipping_city, :shipping_country, :shipping_phone].freeze

  STRING_ATTRS.each do |name|
    attribute name, String
    validates name, presence: true
  end

  attribute :zip, Integer
  attribute :shipping_zip, Integer

  validates :zip, :shipping_zip, presence: true
  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, length: { maximum: 50 }, on: :update
  validates :first_name, :last_name, :city, :country, format: { with: /\A[а-яА-ЯёЁa-zA-Z]+\z/, message: "only allows letters" }, on: :update
  validates :zip, length: { maximum: 10 }, format: { with: /\A[0-9]+\z/, message: "only allows numbers" }, on: :update
  validates :phone, length: { maximum: 15 }, format: { with: /\A^\+[0-9]+\z/, message: "should starts with +" }, on: :update

  validates :shipping_first_name, :shipping_last_name, :shipping_address, :shipping_city, :shipping_zip, :shipping_country, :shipping_phone, length: { maximum: 50 }, on: :update
  validates :shipping_first_name, :shipping_last_name, :shipping_city, :shipping_country, format: { with: /\A[а-яА-ЯёЁa-zA-Z]+\z/, message: "only allows letters" }, on: :update
  validates :shipping_zip, length: { maximum: 10 }, format: { with: /\A[0-9]+\z/, message: "only allows numbers" }, on: :update
  validates :shipping_phone, length: { maximum: 15 }, format: { with: /\A^\+[0-9]+\z/, message: "should starts with +" }, on: :update

  attr_reader :user

  def save
    return false unless valid?
    persist!
    true
  end

  def persist!
    @user.update_attributes(user_params)
  end
end 
