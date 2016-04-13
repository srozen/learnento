module PagesObjectsHelper
  extend Memoist

  def self.page_object(helper_method, page_class)
    define_method(helper_method) do
      page_class.new
    end
    memoize helper_method
  end

  #Example Page Object
  #page_object :root_index, Spec::Pages::General::Index

  page_object :navigation, Spec::Pages::Navigation
  page_object :register, Spec::Pages::Register
  page_object :login, Spec::Pages::Login

end


RSpec.configure { |c| c.include PagesObjectsHelper, type: :feature }
