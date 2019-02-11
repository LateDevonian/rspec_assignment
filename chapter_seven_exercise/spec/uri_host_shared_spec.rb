require 'spec_helper'
require 'rspec'
require 'rack/test'
require_relative 'shared_examples'
require 'addressable'
require 'uri'

RSpec.describe 'Parse_checker' do
  include Rack::Test::Methods
  include RSpec

  describe '#excecute_parse_check' do

    it_behaves_like 'parsing the uri port and host'

  end
end
