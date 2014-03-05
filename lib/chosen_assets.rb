require 'chosen_assets/version'

module ChosenAssets
end

case ::Rails.version.to_s
when /^4/
  require 'chosen_assets/engine'
when /^3\.[12]/
  require 'chosen_assets/engine3'
when /^3\.[0]/
  require 'chosen_assets/railtie'
end

require 'compass-rails'
