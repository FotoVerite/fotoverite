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

class Portfolio < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders] # you can now do MyClass.find('bar')

  has_many :photos

  scope :visible, -> {where(:visible => true)}
end
