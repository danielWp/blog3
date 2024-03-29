# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do

  before do
  	@user = User.new(name: "Example User", email: "user@example.com", 
                     password: "foobar", password_confirmation: "foobar")
  end
  
  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should be_valid }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }

  describe "Quando a senha nao estiver presente" do
  	before { @user.password = @user.password_confirmation = " " }
  	it { should_not be_valid }
  end

  describe "Quando nao combinar a combinacao de senhas" do
  	before { @user.password_confirmation = "mismatch" }
  	it { should_not be_valid }
  end

  describe "Quando a confirmacao da senha e nula" do
  	before { @user.password_confirmation = nil }
  	it { should_not be_valid }
  end

  describe "Quando a senha e muita pequena" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "retorna valor do metodo autenticado" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "com senha valida" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "com senha invalida" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "Quando o nome nao esta presente" do
    before { @user.name = " " }
    it { should_not be_valid }
  end	

  describe "Quando o email nao esta presente" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "Quando o nome e muito extenso" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "Quando o formato do email e invalido" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end

  describe "Quando o formato do email e valido" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end

  describe "Quando o endereco de email ja existe" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

end