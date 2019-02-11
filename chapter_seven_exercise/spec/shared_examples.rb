
require 'spec_helper'


shared_examples 'parsing the uri port and host' do
  let(:http_port_host) { "http://foo.com:9876/" }
  let(:https_port_host) { "https://foo.com:443/" }
  let(:parser) { URI.parse }

    it 'allows you to parse a http port' do
      expect(URI.parse(http_port_host).port).to eq 9876
    end

    it 'allows you to parse a https port' do
      expect(Addressable::URI.parse(https_port_host).port).to eq 443
    end

    it 'allows you to parse a http host' do
       expect(URI.parse(http_port_host).host).to eq 'foo.com'
    end

    it 'allows you to parse a https host' do
      expect(Addressable::URI.parse(https_port_host).host).to eq 'foo.com'

    end
  end

#   context 'parsing the uri host' do
#
#     it 'allows you to parse a http host name' do
#       expect(parser((http_host)).host). to eq 'foo.com'
#     end
#
#     it 'allows you to parse a https host name' do
#       let(parser) { Addressable::URI.parse }
#      expect(parser(https).host).to eq 'foo.com'
#     end
#   end
#
#   shared_examples 'parsing the uri port' do
#
#     it 'allows you to parse a http port' do
#       expect(parser(http_port).port).to eq 9876
#     end
#
#     it 'allows you to parse a https port' do
#       expect(parser(https_port).port).to eq 443
#     end
#   end
# end
