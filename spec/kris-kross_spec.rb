require 'spec_helper'

describe Kris::Kross, "#new" do
  let(:app) { mock() }

  it "should initialize a handler and configure it" do
    Kris::Kross::Handler.instance.should_receive(:app=).with(app)
    Kris::Kross.new(app)
  end
end

describe Kris::Kross, "#configure" do
  let(:proc) { -> { "some proc" } }

  it "passes block on to Configuration" do
    Kris::Kross::Configuration.instance.should_receive(:configure).with(&proc)
    Kris::Kross.configure(&proc)
  end
end

describe Kris::Kross, "#call" do
  let(:app) { mock() }
  let(:env) { mock() }
  let(:handler) { mock() }

  it "passes arguments on to a handler" do
    Kris::Kross::Handler.stub(:instance).and_return(handler)
    handler.should_receive(:app=).with(app)
    handler.should_receive(:call).with(env)

    Kris::Kross.new(app).call(env)
  end
end
