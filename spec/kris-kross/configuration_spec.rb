require 'spec_helper'

describe Kris::Kross::Configuration, "#configure" do
  let(:instance) { Kris::Kross::Configuration.instance }

  it "should allow configuration via blocks with method calls" do
    instance.configure do |c|
      c.origins %w(http://host-1 http://host-2)
    end

    instance.origins.should == %w(http://host-1 http://host-2)
  end

  it "should allow configuration via blocks with assignment" do
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

describe Kris::Kross::Configuration, ".hosts" do
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
