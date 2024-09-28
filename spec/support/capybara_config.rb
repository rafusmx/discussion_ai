#Ensure Log directory exists
%x(mkdir -p tmp/selenium_logs)

Capybara.register_driver :firefox do |app|
  # desired_caps = Selenium::WebDriver::Remote::Capabilities.new :firefox
  # options = Selenium::WebDriver::Firefox::Options.new

  Capybara::Selenium::Driver.new(app, browser: :firefox)

  # Capybara::Selenium::Driver.new(app, {
  #   browser: :firefox,
  #   desired_capabilities: desired_caps,
  #   options: options,
  #   driver_opts: {
  #     log_path: "./tmp/selenium_log/selenium#{Time.now.to_i}.log",
  #     verbose: true
  #   }
  # })
end

Capybara.javascript_driver = :firefox
Capybara.default_driver = :firefox
