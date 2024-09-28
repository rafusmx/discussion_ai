module DiscussionHelper
  def prompt_stamp
    "#{Time.now.strftime("%H:%M:%S")}>"
  end
end
