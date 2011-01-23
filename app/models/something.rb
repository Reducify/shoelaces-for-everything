class Something < ActiveRecord::Base
  mount_uploader :something, SomethingUploader
  attr_accessor :shoelace
end
