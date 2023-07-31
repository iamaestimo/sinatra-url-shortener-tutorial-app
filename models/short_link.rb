# frozen_string_literal: true
class ShortLink < ActiveRecord::Base
  validates :short_url, presence: true
  validates :long_url, presence: true
end
