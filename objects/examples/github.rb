#!/usr/bin/env ruby
# vim: ft=ruby ts=2 sw=2 expandtab
#
# date: Fri Jul  8 17:52:29 2016

require 'json'
require 'open-uri'

#
# Definitions
#
def getinput(describe)
  STDERR.print("#{describe}: ")
  STDIN.gets.chomp
end

def jsonfile
  File.join(File.dirname($0), "#{File.basename($0, '.*')}.json")
end

#
# Main
#
file = jsonfile

# Check for object/personal.json
correct = false
resp = nil
json_string = ''
unless File.exist?(file)
    begin
      username = getinput 'Enter your GitHub username'
      #username = 'dexterp'
      resp = open("https://api.github.com/users/#{username}",
                  'User-Agent' => 'Codestrap-Github-Metadata')
      if (resp.status[0] == '200') then
        correct = true
      else
        puts "Invalid username https://api.github.com/users/#{username}"
      end
    end until correct
end
resp.each_line do |line|
  json_string << line
end
json_hash = JSON.parse(json_string)

if correct
  File.open(file, 'w') do |file|
    file.puts(JSON.pretty_generate(json_hash))
  end
end

if File.exist?(file)
  File.open(file, 'r') do |file|
    file.each_line do |line|
      print line
    end
  end
end
