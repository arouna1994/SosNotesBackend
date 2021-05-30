class SmsWorker
  require 'openssl'
  include SuckerPunch::Job

  def perform(to,msg)
    begin
      num_telephone = to
      if to.start_with?("00221")
        num_telephone["00221"] = "+221"
      end
      if to.start_with?("221")
        num_telephone["221"] = "+221"
      end
      payload = {
          :outboundSMSMessageRequest => {
              :address => "tel:%s" %num_telephone,
              :senderName => "BINDDOC",
              :senderAddress => "tel:+22100000000",
              :outboundSMSTextMessage => {
                  :message => "%s" %msg
              }
          }
      }
      ctx = OpenSSL::SSL::SSLContext.new
      #clé généré le 13 octobre 2020
      resp = HTTP.auth('Bearer F1x1Ei6gN0UEo8O1boDFGWxssIrz')  
          .timeout(:write => 5, :connect => 10, :read => 10)
          .headers(:accept => "application/json")
          .post('https://api.orange.com/smsmessaging/v1/outbound/tel%3A%2B22100000000/requests', :json => payload, :ssl_context => ctx)

      list_form =  JSON.parse(resp.body)

      puts "----"+list_form.to_s
      puts "---------------------------------------"
      puts "Sending SMS"
      puts "---------------------------------------"
    rescue Exception => e
      puts "-----------------------------"
      puts "Exception sending sms"
      puts e.to_s
      puts "-----------------------------"
    end
  end
end