require 'spec_helper'
describe 'syslogng' do

  context 'with defaults for all parameters' do
    it { should contain_class('syslogng') }
  end
end
