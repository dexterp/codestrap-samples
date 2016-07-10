#!/usr/bin/env ruby
# vim: ft=ruby ts=2 sw=2 expandtab
#
# date: Fri Jul  8 17:52:29 2016
# contact/creator: Dexter Plameras

require 'json'

#
# Definitions
#
def getinput(describe)
  STDERR.print("#{describe}: ")
  STDIN.gets.chomp
end

#
# Main
#
file = File.join(File.dirname($0), "#{File.basename($0, '.*')}.json")

# Check for object/personal.json
correct = false
unless File.exist?(file)
  output = nil
  begin
    STDERR.puts "Initial setup #{file}"
    output = {
        full_name: getinput('Full Name'),
        email: getinput('Email Address')
    }

    puts JSON.pretty_generate(output)
    check = getinput "Does this look correct? (Yes/No)"

    correct = true if check =~ /^(?:[Yy][Ee][Ss]|[Yy])$/
  end until correct
end

if correct
  File.open(file, 'w') do |file|
    file.puts(JSON.pretty_generate(output))
  end
end

if File.exist?(file)
  File.open(file, 'r') do |file|
    file.each_line do |line|
      print line
    end
  end
end

