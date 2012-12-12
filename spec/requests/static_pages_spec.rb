require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: 'Sign up') }
  end
end

describe "profile page" do
  # Code to make a user variable
  before { visit user_path(user) }

  it { should have_selector('h1',    text: user.name) }
  it { should have_selector('title', text: user.name) }
end

describe "StaticPages" do

  subject { page }

  describe "Home page" do
    before { visit root_path } 

    it { should have_content('blog3') }
    it { page.should have_selector 'title',
                        text: "Ruby on Rails Tutorial blog3 | Home"}
    it { should have_selector('title', text: full_title('')) }

  end

  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_selector('title', text: full_title('Help')) }

  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('Sobre') }
    it { should have_selector('title', full_title('Help')) }

  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_selector('title', text: full_title('Contact')) }

  end

end