require 'site_prism'
require 'capybara/rails'
#require 'capybara/poltergeist'

module Capybara::AliasHelper

  def resources_path(*parts)
    Pathname(File.join(File.realpath(__FILE__), '..', '..', '..', 'resources', *parts)).expand_path
  end



end



RSpec.configure { |c| c.include Capybara::AliasHelper }

SitePrism::Page.send :include, Capybara::AliasHelper
SitePrism::Section.send :include, Capybara::AliasHelper