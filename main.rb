#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

require 'optparse'
require 'rotp'
require 'colorize'
#require "byebug"

def copy_to_clipboard(input)
  copy_command = (/darwin/ =~ RUBY_PLATFORM)!=nil ? "pbcopy" : "xclip"
  str = input.to_s
  IO.popen(copy_command, 'w') { |f| f << str  }
  puts "Copied.".green
  str
end

params = ARGV.getopts("", "config:~/.otp.yml", "base32")

if params["base32"]
  base32 = ROTP::Base32.random_base32
  copy_to_clipboard base32
  puts base32.yellow
  exit
end

config_path = File.expand_path(params["config"])
unless File.exists?(config_path)
  puts "#{config_path} not found.\nExit now.".red
  abort
end

begin
  require 'yaml'
  setting = YAML.load_file(config_path)
  setting = setting["otp"]
  raise unless setting
rescue
  puts "Incorrect config file format. (#{config_path})".red
  abort
end

if ARGV.length == 0
  puts "You should give at least one keyword.".red
  abort
end

unless secret = setting[ARGV[0]]
  puts "Keyword \"#{ARGV[0]}\" not found in config file #{config_path} .".red
  abort
end

totp = ROTP::TOTP.new(secret)
res = totp.now
puts res.yellow
copy_to_clipboard res

exit
