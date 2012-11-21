require 'spec_helper'

describe Kris::Kross::Handler do
  subject { Kris::Kross::Handler.new(app) }

  let(:app) { mock() }
  let(:response) { subject.call(env) }
  let(:status) { response[0] }
  let(:headers) { response[1] }
  let(:body) { response[2] }

  let(:request_method) { 'OPTIONS' }
  let(:allow_origin) { 'http://my-host https://my-host' }

  let(:configuration) { mock() }

  before do
    Kris::Kross::Configuration.stub(:hosts).and_return(allow_origin)
  end

  let(:env) { {
      'REQUEST_METHOD' => request_method,
      'REQUEST_PATH' => '/'
  } }

  describe "OPTIONS request" do
    it "should return a 200 status" do
      status.should == 200
    end

    it "should include Access-Control headers" do
      headers['Access-Control-Allow-Origin'].should == allow_origin
      headers["Access-Control-Allow-Methods"].should == "POST, GET, OPTIONS"
      headers["Access-Control-Allow-Headers"].should == "X-Requested-With, X-Prototype-Version, Authorization, Authentication"
      headers["Access-Control-Max-Age"].should == "172800"
      headers["Access-Control-Allow-Credentials"].should == 'true'
    end
  end

  describe "POST request" do
    let(:request_method) { 'POST' }
    let(:application_response_body) { ["some text from the application"] }
    let(:application_response) {
      [
          200,
          {"header"=>'content'},
          application_response_body
      ]
    }

    before do
      app.should_receive(:call).with(env).and_return(application_response)
    end

    it "should call the Rails dispatcher with the request environment" do
      subject.call(env)
    end

    it "should return the body text from the app" do
      body.should == application_response_body
    end

    it "should inject Allow-Origin headers into the response" do
      headers['Access-Control-Allow-Origin'].should == allow_origin
      headers["Access-Control-Allow-Credentials"].should == 'true'
    end
  end
end
