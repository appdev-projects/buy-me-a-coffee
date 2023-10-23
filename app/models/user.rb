# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  stripe_customer_id     :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :subscriptions
  has_one :active_subscription, -> { active.order(created_at: :desc).limit(1) }, class_name: "Subscription"

  def stripe_customer
    return create_stripe_customer unless stripe_customer_id.present?

    Stripe::Customer.retrieve(stripe_customer_id)
  rescue Stripe::InvalidRequestError
    create_stripe_customer
  end

  private

  def create_stripe_customer
    customer = Stripe::Customer.create(email: self.email)
    update(stripe_customer_id: customer.id)
    customer
  end
end
