require 'spec_helper'

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
    Kris::Kross::Handler.should_receive(:new).with(app).and_return(handler)
    handler.should_receive(:call).with(env)

    Kris::Kross.new(app).call(env)
  end
end
