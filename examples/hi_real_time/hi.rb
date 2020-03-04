# frozen_string_literal: true
require 'slack-ruby-client'
require 'async'

Slack.configure do |config|
  config.token = 'xoxb-3315023640-888934731009-mW8iuzjEF6RiULWUtTRbIHAI'
  config.logger = Logger.new(STDOUT)
  config.logger.level = Logger::INFO
  raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

client = Slack::RealTime::Client.new(websocket_ping: 42)

client.on :hello do
  puts(
    "Successfully connected, welcome '#{client.self.name}' to " \
    "the '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
  )
end

client.on :message do |data|
  # puts data

  # client.typing channel: data.channel

  case data.text
  when 'bot hi'
    client.message channel: data.channel, text: "Hi <@#{data.user}>!"
  when 'cc tem arch'
    client.message channel: data.channel, text: "<@U6GMLJM8X> <@USC4ARMQ8> <@U84LNHGLS> <@U9TCU5QBC> <@US1HETAV7> <@US1RMPR4K> <@U9UDR7STZ> <@U9UPY0X9A> <@USC42T0G5> <@UN1N24WUB> <@US0KDV28K> <@USE06RJUF> <@U03F6EQAS>"
  when 'cc tem'
    client.message channel: data.channel, text: "<@U6GMLJM8X> <@USC4ARMQ8> <@U84LNHGLS> <@U9TCU5QBC> <@US1HETAV7> <@U9UDR7STZ> <@U9UPY0X9A> <@USC42T0G5> <@UN1N24WUB> <@US0KDV28K> <@USE06RJUF>"
  when 'cc arch'
    client.message channel: data.channel, text: "<@US1RMPR4K> <@U03F6EQAS>"
  when 'piket'
    client.message channel: data.channel, text: "Sprint 5A : <@UN1N24WUB> <@U84LNHGLS>\nSprint 5B : <@USE06RJUF> <@UN1N24WUB>\nSprint 6A : <@U9TCU5QBC> <@USE06RJUF>\nSprint 6B : <@US1HETAV7> <@U9TCU5QBC>\nSprint 7A : <@USC42T0G5> <@US1HETAV7>\nSprint 7B : <@U6GMLJM8X> <@USC42T0G5>\nSprint 8A : <@USC4ARMQ8> <@U6GMLJM8X>\nSprint 8B : <@U9UPY0X9A> <@USC4ARMQ8>\nSprint 9A : <@U84LNHGLS> <@U9UPY0X9A>"
  when /^bot/
    client.message channel: data.channel, text: "Sorry <@#{data.user}>, what?"
  end
end

client.on :close do |_data|
  puts 'Connection closing, exiting.'
end

client.on :closed do |_data|
  puts 'Connection has been disconnected.'
end

client.start!
