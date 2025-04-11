require "json"

class PackageGroupError < StandardError; end

def validate_package_groups(file_path)
  parsed = JSON.parse(File.read file_path)
  raise PackageGroupError.new("Root object is not a hash") unless parsed.is_a?(Hash)
  parsed.each do |k,v|
    raise PackageGroupError.new("Package list for #{k} is not an array") unless v.is_a?(Array)
  end
end

desc "check JSON syntax"
task :validate_all do
  invalid = false
  FileList.new("*/package-groups.json").each do |path|
    begin
      puts "validating #{path}"
      validate_package_groups(path)
    rescue JSON::ParserError, PackageGroupError => e
      STDERR.puts "#{path} -> #{e}"
      invalid = true
    end
  end
  exit(5) if invalid
end

task :default => [:validate_all]
