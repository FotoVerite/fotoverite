# == Schema Information
#
# Table name: photos
#
#  id           :integer          not null, primary key
#  portfolio_id :integer
#  title        :string
#  flickr_id    :string
#  secret       :string
#  medium_url   :string
#  large_url    :string
#  visible      :boolean          default("t")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Photo < ActiveRecord::Base
  belongs_to :portfolio

  scope :visible, -> {where(:visible => true)}

end
