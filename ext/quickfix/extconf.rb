require 'mkmf'
require 'open3'

dir_config("quickfix", ["."], ".")

# Helpers to fetch config values
def fetch_pg_includes
  stdout, _ = Open3.capture2("pg_config --includedir")
  stdout.strip
end

# Set flags
cxxflags = "-std=c++20 -DHAVE_SSL=1 -DHAVE_POSTGRESQL=1"
pg_includes_dir = fetch_pg_includes

cppflags = "-I#{pg_includes_dir}"
ldflags = "-lssl -lcrypto"

puts "Using PostgreSQL from: #{pg_includes_dir}"
puts "CXXFLAGS: #{cxxflags}"
puts "CPPFLAGS: #{cppflags}"
puts "LDFLAGS: #{ldflags}"

# Apply the flags
$CXXFLAGS += " #{cxxflags}"
$CPPFLAGS += " #{cppflags}"
$LDFLAGS  += " #{ldflags}"

create_makefile("quickfix")
