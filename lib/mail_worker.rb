class MailWorker
  include SuckerPunch::Job

  def perform(from, to, subject, body)
    begin
      client = Postmark::ApiClient.new(ENV["POST_MARK_API_TOKEN"], http_open_timeout: 15)
      client.deliver(from: from,
                     to: to,
                     subject: subject,
                     html_body: body)
      puts "---------------------------------------"
      puts "Sending Email"
      puts "---------------------------------------"
    rescue Exception => e
      puts "-----------------------------"
      puts "Exception sending mail"
      puts e.to_s
      puts "-----------------------------"
    end

  end
end