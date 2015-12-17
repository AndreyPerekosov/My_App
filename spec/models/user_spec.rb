require 'rails_helper'

RSpec.describe User do #type: :model можно не писать т.к. в rails_helper есть запись позволяющая этого не делать
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it {should have_many (:questions) }
end