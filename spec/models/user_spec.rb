require 'rails_helper'

RSpec.describe User do #type: :model можно не писать т.к. в rails_helper есть запись позволяющая этого не делать
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it {should have_many (:questions) }

  #check instance method of User model
    describe do
      let(:object) {create(:question)}
      it 'return true if user is author of object' do
        #expect(user.owner_of?(object)).to eq true
        #тоже самое expect(user.owner_of?(object)).to be_truthy либо если учесть что rspec для всех методов предикатов:
        #может от owner_of? образовать следующий метод be_owner_of и при исполнении преобразовывается в owner_of? и вызывается у обоих объектов  
        expect(object.user).to be_owner_of(object)
      end

      it 'return false if user is not author of object' do
        user = create(:user)
        expect(user).to_not be_owner_of(object)
      end
    end 
end