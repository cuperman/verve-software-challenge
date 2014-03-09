require 'spec_helper'
include Capybara::DSL

describe "Javascript QUnit tests", :type => :request, :js => true do
  it "should pass when executing qunit tests" do
    MAX_RUNNING_TIME_PER_SCRIPT = 60 # max time for each QUnit test
    delays = 0

    visit qunit_tests_path

    while delays < MAX_RUNNING_TIME_PER_SCRIPT
      doc = Nokogiri::HTML(page.body)
      if (doc.css('#qunit-testresult .passed').empty?)
        sleep 1
        delays = delays + 1
      else
        break
      end
    end

    if (doc.css('#qunit-testresult .passed').empty?)
      false.should eql(true), "The tests failed and did not complete within #{MAX_RUNNING_TIME_PER_SCRIPT}s"
    else
      doc.css('ol#qunit-tests>li').each do |test|
        test.css('.counts .failed').text.strip.should eql("0"), "QUnit test '#{test.css('span.test-name').text.strip}' failed"
      end
    end
  end
end
