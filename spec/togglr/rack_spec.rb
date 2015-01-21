require 'togglr/rack'

describe Togglr::RackAPI do
  include Rack::Test::Methods

  def app
    @app ||= Togglr::RackAPI.new
  end

  it 'should respond to /' do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq '{}'
  end

  context 'when there are toggles' do
    let(:file_contents) do
      %q{---
:category:
  :true_toggle:
    :value: true
  :false_toggle:
    :value: false
  :some_toggle:
    :value: false
      }
    end

    let(:toggles) { {'test_toggle' => 'ok' } }
    it 'contains the toggles and their values' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to eq toggles.to_json
    end
  end
end

