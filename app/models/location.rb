class Location < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  
  validates_presence_of :address, format:{ message: :provide_address }

  #validates_presence_of :address,
  #    :message => Proc.new { |location, data|
  #    "You must provide #{data[:attribute]} for "
  #    }

end
