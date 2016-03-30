require 'spec_helper'

describe User do
  let(:kendrick){User.create(first_name: "Kendrick", last_name: "Lamar", email: "klamar@gmail.com", password: "test")}
  
  describe "#create" do 
    it "creates a user with a first name" do 
      expect(kendrick.first_name).to eq("Kendrick")  
    end

    it "creates a user with a last name" do
      expect(kendrick.last_name).to eq("Lamar")
    end

    it "creates a user with an e-mail address" do
      expect(kendrick.email).to eq("klamar@gmail.com")
    end
  end

  describe "#password" do
    it "returns nil if the password is not correct" do
      expect(User.authenticate("klamar@gmail.com", "blarf")).to eq(nil)
    end

    it "returns a user object if the password is correct" do 
      expect(User.authenticate("klamar@gmail.com", "test")).to be_a_kind_of(User)
    end
  end
end
