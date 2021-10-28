class VideoChatActiveChatPage < VideoChatLandingPage

  include PageObject

#screenshot panel
  div(:screenshot_header, class: 'side-captures__head')
  div(:screenshot_header_count) { screenshot_header_element.div_element(span: 'side-captures__count') }
  div(:screenshot_section, class: 'side-captures__items')
  div(:screenshot_capture, class: 'screen-capture__widget')
  div(:screenshot_filename, span: 'screen-capture__filename')
  button(:delete_screenshot, class: 'screen-capture__delete')


  def current_screenshots
    do_until_true('Waiting on screenshot area to be present', timeout: 5) { element_present?('screenshot_section') }
    screenshot_section_element.div_elements(class: 'screen-capture__widget').map(&:text)
  end

  def wait_for_screenshot_button
    wait_for_element('take_screenshot', timeout: 2)
    do_until_true(timeout: 5) { toastify_success_elements.collect(&:text).include?('New participant has joined') }
  end

  def take_screenshot(count)
    existing_screenshot_count = screenshot_section_element.div_elements(class: 'screen-capture__widget').count
    count.to_i.times do |i|
      i              += 1
      expected_count = existing_screenshot_count.zero? ? i : existing_screenshot_count + i
      sleep 1.5
      click_element('take_screenshot')
      do_until_true(timeout: 5) { screenshot_section_element.div_elements(class: 'screen-capture__widget').count == expected_count }
    end
  end




end