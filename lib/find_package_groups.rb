#!/bin/env ruby

require 'octokit'
require 'dotenv/load'
require 'json'

slug = ARGV[0]
prefix = ARGV[1] || "packages"

if slug.nil? || slug.strip == ""
  puts "Depfu's Package Group finder. Automate ALL THE THINGS!"
  puts
  puts "Usage: find_package_groups <slug> [<prefix>]"
  puts "slug is GitHub repo slug (e.g. flowbyte/package_group_finder)"
  puts "prefix is packages folder (defaults to 'packages')"
  puts
  exit 1
end

options = {
  access_token: ENV['GITHUB_ACCESS_TOKEN']
}

client = Octokit::Client.new(options)

default_branch = client.repo(slug).default_branch
puts "Using repo: #{slug}"
puts "Using branch: #{default_branch}"

all = client.contents(slug, path: prefix, ref: default_branch, accept: "application/vnd.github.v3.object")

dirs = all.entries.select {|e | e.type == "dir" }.map(&:path)

packages = dirs.map do |dir|
  package_json = client.contents(slug, path: File.join(dir, "package.json"), ref: default_branch, accept:"application/vnd.github.v3.raw")
  parsed = JSON.parse(package_json)
  { name: parsed["name"], version: parsed["version"] }
end

version_to_group = packages.find {|p| !p[:version].nil? }[:version]

puts "Using #{version_to_group} as canonical version."

puts packages.select{|p| p[:version] == version_to_group }.map{|p| %Q["#{p[:name]}"]}.join(",\n")
