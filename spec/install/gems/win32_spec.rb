require 'spec_helper'

describe "bundle install with win32-generated lockfile" do
  it 'should read lockfile' do
    File.open(bundled_app('Gemfile.lock'), 'wb') do |f|
      f << "GEM\r\n"
      f << "  remote: file:#{gem_repo1}/\r\n"
      f << "  specs:\r\n"
      f << "\r\n"
      f << "    rack (1.0.0)\r\n"
      f << "\r\n"
      f << "PLATFORMS\r\n"
      f << "  ruby\r\n"
      f << "\r\n"
      f << "DEPENDENCIES\r\n"
      f << "  rack\r\n"
    end

    install_gemfile <<-G, :exit_status => true
      source "file://#{gem_repo1}"

      gem "rack"
    G
    @exitstatus.should == 0
  end
end
