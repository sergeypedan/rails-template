# frozen_string_literal: true

module WaitForAjax

  # scenario 'skip test period', js: true do
  #   visit schedules_path
  #   select 'Upcoming 60 days', from: 'interval'
  #   click_on 'Refresh'
  #   wait_for_ajax
  #   expect(page).to have_content(device_7_days.serial)
  # end
	#
  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active')&.zero?
  end
end

RSpec.configure do |config|
  config.include WaitForAjax, type: :feature
end
