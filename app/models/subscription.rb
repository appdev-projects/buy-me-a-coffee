# == Schema Information
#
# Table name: subscriptions
#
#  id                     :integer          not null, primary key
#  canceled_at            :datetime
#  price                  :integer
#  status                 :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  stripe_subscription_id :string
#  user_id                :integer          not null
#
# Indexes
#
#  index_subscriptions_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Subscription < ApplicationRecord
  belongs_to :user

  scope :active, -> { where(status: "active") }
end
