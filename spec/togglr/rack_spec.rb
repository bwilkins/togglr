require 'rack/test'
require 'togglr'
require 'togglr/rack'
require 'togglr/toggles'

describe Togglr::RackAPI do
  include Rack::Test::Methods

  def app
    @app ||= Togglr::RackAPI.new
  end

  it 'responds to /' do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq '{}'
  end

  context 'when there are toggles' do

    let(:toggles) { { toggle_one: { value: true }, toggle_two: { value: false } } }

    before do
      Togglr::Toggles.register_toggles(toggles)
    end

    it 'contains the toggles and their values' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to eq toggles.to_json
    end
  end
end

