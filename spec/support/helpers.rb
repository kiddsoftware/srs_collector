module GlobalSpecHelpers
  # Mock up an external web server that serves a file.  Returns the URL of
  # the image.
  def stub_file_url(filename)
    file_url = "http://www.example.com/#{filename}"
    file_path = File.expand_path("../../fixtures/files/#{filename}", __FILE__)
    mime = Mime::Type.lookup_by_extension(File.extname(filename).sub(/\A\./, ''))
    stub_request(:get, file_url).
      to_return(body: File.new(file_path), headers: { 'Content-Type' => mime })
    file_url
  end

  def stub_image_url
    stub_file_url("image.png")
  end
end

module ControllerSpecHelpers
  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out(user)
    session[:user_id].should == user.id
    session[:user_id] = nil
  end

  def json
    @json ||= JSON.parse(response.body)
  end
end

module FeatureSpecHelpers
  # Only valid after sign_up.
  attr :current_user

  # We have some asynchronous DOM requests that occasionally take a long
  # time, but we can't finish a scenario until they're done using our web
  # server, or we'll get weird database state.  We can call this at the end
  # of a scenario if we want to rule out this problem and focus on other
  # possible reasons for mysterious intermittent failures.
  #
  # We may try disabling this later, to see whether we still need it.
  def wait_for_jquery
    Timeout.timeout(Capybara.default_wait_time) do
      until page.evaluate_script("$.active === 0")
      end
    end
  end

  def sign_up(options={})
    supporter = options[:supporter] || false
    first(:link, "Sign Up").click
    find("input[placeholder='Email']").set("user@example.com")
    find("input[placeholder='Password']").set("password")
    find("input[placeholder='Password confirmation']").set("password")
    click_button "Sign Up"    
    page.should have_text("Your account has been created")
    user = User.where(email: "user@example.com").first!
    @current_user = user
    if supporter
      user.supporter = true
      user.save!
      visit "/"
    end
  end

  def sign_in(email, password)
    first(:link, "Sign In").click
    find("input[placeholder='Email']").set(email)
    find("input[placeholder='Password']").set(password)
    click_button "Sign In"
    page.should have_text("Sign Out")
  end

  def fill_in_html(field, options)
    with = options[:with]
    page.execute_script(<<"EOD")
(function () {
  var editor = $(#{field.to_json}).data("wysihtml5");
  editor.setValue(#{with.to_json});
  editor.fire("change");
})();
EOD
  end

  def expect_html_to_match(field, regex)
    find(field, visible: false)
    timeout_at = Time.now + 3.seconds
    loop do
      actual = page.evaluate_script(<<"EOD")
(function () {
  var editor = $(#{field.to_json}).data("wysihtml5");
  return editor.getValue();
})();
EOD
      break if actual =~ regex
      if Time.now > timeout_at
        fail("Expected #{regex.inspect}, got #{actual.inspect} in #{field}")
      end
    end
  end

  def select_all(field)
    page.execute_script(<<"EOD")
(function () {
  var editor = $(#{field.to_json}).data("wysihtml5");
  var selection = editor.composer.selection;
  selection.selectNode(selection.doc.documentElement);
})();
EOD
  end

  def expect_nested_page(src)
    page.should have_xpath("//iframe[@src='#{src}']")
  end

end
