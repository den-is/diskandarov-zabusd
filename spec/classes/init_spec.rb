require 'spec_helper'
describe 'zabusd' do

  context 'with defaults for all parameters' do
    it { should contain_class('zabusd') }
  end
end
