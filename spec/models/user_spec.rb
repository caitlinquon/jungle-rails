require 'rails_helper'

RSpec.describe User, type: :model do
  
  before(:each) do
    @user = User.new(first_name: 'Emma', last_name: 'Quon', email: 'test@gmail.COM', password:'kitty', password_confirmation:'kitty')
  end
  
  describe '(validations)' do

    it 'password fields should match' do
      user = User.new(
        first_name: 'Emma',
        last_name: 'Quon',
        email: 'emma@gmail.com',
        password: '1234',
        password_confirmation: '123'
      )
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'email should be unique' do
      @user.save
      @user1 = User.new(first_name: 'Sophie', last_name: 'Quon', email: 'TEST@GMAIL.com', password: 'puppy', password_confirmation: 'puppy')
      expect(@user1.valid?).to be false
      expect(@user1.errors.full_messages).to include("Email has already been taken")
    end

    it 'password should have at least 5 characters' do
      user = User.new(
        first_name: 'Emma',
        last_name: 'Quon',
        email: 'emma@gmail.com',
        password: '1234',
        password_confirmation: '1234'
      )
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end
  end

  describe '.authenticate_with_credentials' do  
    it 'should not care about case when searching by email' do
      @user.save
      expect(User.find_by_email_ignore_case('tesT@Gmail.com')).to_not eql(nil)
    end
    
    it 'should have authenticated email and password' do
      @user.save
      expect(User.authenticate_with_credentials(' test@gmAil.COM', 'kitty')).to_not eql(nil)
    end
  end
end
