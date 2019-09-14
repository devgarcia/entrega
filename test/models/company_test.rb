# == Schema Information
#
# Table name: companies
#
#  id                     :bigint           not null, primary key
#  name                   :string
#  telephone              :string
#  email                  :string
#  radius                 :integer
#  status                 :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#

require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
