And(/^I click the (create link|end call|mute|unmute|show video|hide video|screenshot) button$/) do |button|
  on_page(@video_chat_active_chat_page) do |page|
    page.wait_for_page_to_load(timeout: 5)
    case button
      when 'create link'
        page.click_element('create_video_chat_link_button')
      when 'end call'
        #it  takes a second to load notes from during chat to after chat
        sleep 1
        page.click_element('video_chat_end_call')
      when 'mute', 'unmute'
        sleep 1
        page.click_element('video_chat_mute_unmute')
      when 'show video', 'hide video'
        page.click_element('video_chat_show_hide')
      when 'screenshot'
        page.click_element('take_screenshot')
    end
  end
end

When(/^I click and take(?: (\d+) screenshots)?$/) do |i|
  i = 1 if i.nil?
  @video_chat_active_chat_page.wait_for_screenshot_button unless @chat_initiated
  @video_chat_active_chat_page.take_screenshot(i)
  @chat_initiated = true
end

Then(/^I see my screenshot on the video chat sidebar$/) do
  do_until_true { @video_chat_active_chat_page.element_present?('screenshot_capture') }
end

Then(/^The total screenshot amount is (\d+)$/) do |screenshot_count|
  on_page(@video_chat_active_chat_page) do |page|
    expect(page.current_screenshots.count.to_i).to eq(screenshot_count)
  end
end

When(/^I click the video chat button(:? to upgrade)?$/) do |intent|
  if intent
    on_page(@looker_action_bar).click_video_chat_button
    on_page(@looker_page).wait_modal_open
  else
    on_page(@looker_action_bar).click_video_chat_button
    @video_chat_landing_page.use_video_chat_tab
  end
end