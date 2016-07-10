require 'spec_helper'
describe 'puppetmodule' do

  context 'with defaults for all parameters' do
    it { should contain_class('puppetmodule') }
  end
end
