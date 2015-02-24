# == Schema Information
#
# Table name: admins
#
#  id                        :integer          not null, primary key
#  first_name                :string(50)
#  last_name                 :string(50)
#  username                  :string
#  email                     :string
#  hashed_password           :string           default(""), not null
#  enabled                   :boolean          default("t")
#  remember_token            :string(40)
#  remember_token_expires_at :datetime
#  created_at                :datetime
#  updated_at                :datetime
#

require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
