require 'spec_helper'

describe Kris::Kross::Configuration, "#configure" do
  before { Kris::Kross::Configuration.reset }
  let(:instance) { Kris::Kross::Configuration.instance }

  describe "origins" do
    it "should allow configuration via method calls" do
      instance.configure do |c|
        c.origins %w(http://host-1 http://host-2)
      end

      instance.origins.should == %w(http://host-1 http://host-2)
    end

    it "should allow configuration via assignment" do
      instance.configure do |c|
        c.origins = %w(http://host-3 http://host-4)
      end

      instance.origins.should == %w(http://host-3 http://host-4)
    end

    it "should accept string origins" do
      instance.configure do |c|
        c.origins = "http://blah.blah"
      end

      instance.origins.should == %w(http://blah.blah)
    end
  end

  describe "headers" do
    it "should allow configuration via method calls, mixed into defaults" do
      instance.configure do |c|
        c.headers %w{X-Blah-Blah X-Blah-Blah-Blah}
      end

      instance.headers.should == %w{
        X-Requested-With
        X-Prototype-Version
        Authorization
        Authentication
        X-Blah-Blah
        X-Blah-Blah-Blah}.join(' ')
    end

    it "should allow configuration with assignment, mixed into defaults" do
      instance.configure do |c|
        c.headers = %w{X-Blah-Blah X-Blah-Blah-Blah}
      end

      instance.headers.should == %w{
        X-Requested-With
        X-Prototype-Version
        Authorization
        Authentication
        X-Blah-Blah
        X-Blah-Blah-Blah}.join(' ')
    end
  end
end

describe Kris::Kross::Configuration, ".headers" do
  before { Kris::Kross::Configuration.reset }
  let(:instance) { Kris::Kross::Configuration.instance }
  let(:default_headers) { %w{X-Requested-With X-Prototype-Version Authorization Authentication} }

  context "with only default headers" do
    it "should return just the defaults" do
      Kris::Kross::Configuration.headers.should == default_headers.join(' ')
    end
  end

  context "with extra headers" do
    before do
      instance.configure do |c|
        c.headers %w(X-Blah)
      end
    end

    it "should return headers as a string" do
      Kris::Kross::Configuration.headers.should == (default_headers << "X-Blah").join(' ')
    end
  end
end

describe Kris::Kross::Configuration, ".hosts" do
  before { Kris::Kross::Configuration.reset }
  let(:instance) { Kris::Kross::Configuration.instance }

  before do
    instance.configure do |c|
      c.origins %w(http://host-1 http://host-2)
    end
  end

  it "should return origins as a string" do
    Kris::Kross::Configuration.hosts.should == "http://host-1 http://host-2"
  end
end
