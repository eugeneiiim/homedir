#! /usr/bin/ruby

require 'rubygems'
require 'pony'

if ARGV.length < 3
  puts 'args: to subject body'
  exit
end

to, subject, body = ARGV

File.open("#{ENV['HOME']}/.sendmail", 'r').readlines.each do |l|
  eval(l.strip)
end

Pony.mail({
  :to => to,
  :subject => subject,
  :body => body,
  :via => :smtp,
  :via_options => {
    :address              => 'smtp.gmail.com',
    :port                 => '587',
    :enable_starttls_auto => true,
    :user_name            => SENDER_GMAIL,
    :password             => SENDER_GMAIL_PASSWORD,
    :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
    :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
  }
})
