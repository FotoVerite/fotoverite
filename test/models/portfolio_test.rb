# == Schema Information
#
# Table name: portfolios
#
#  id               :integer          not null, primary key
#  title            :string
#  flickr_id        :string
#  secret           :string
#  primary_photo_id :string
#  medium_url       :string
#  visible          :boolean          default("t")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class PortfolioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
