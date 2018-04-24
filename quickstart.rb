require 'bundler'
Bundler.require()
Dotenv.load

sl = ENV['secret'].length

post '/door' do
    Twilio::TwiML::VoiceResponse.new.gather(numDigits: sl, action: '/input') do |g|
        g.say(ENV['message'])
    end.to_s
end

post '/input' do
    Twilio::TwiML::VoiceResponse.new do |resp|
        if params['Digits'] == ENV['secret']
            resp.play(digits: ENV['digit'])
        end
    end.to_s
end

post '/forward' do
    Twilio::TwiML::VoiceResponse.new.dial do |dial|
        dial.number(ENV['number'])
    end.to_s
end
