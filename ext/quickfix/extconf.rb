require 'mkmf'
require 'rake/extensiontask'
require 'open3'

dir_config("quickfix", ["."], ".")


# Helpers to fetch config values
def fetch_pg_includes
  stdout, _ = Open3.capture2("pg_config --includedir")
  stdout.strip
end

def fetch_openssl_dir
  stdout, _ = Open3.capture2("pkg-config --variable=prefix openssl")
  stdout.strip
end

def fetch_swig_dir
  File.expand_path("../../../quickfix/src/swig", __FILE__)
end

# Set flags
cxxflags = "-std=c++20 -DHAVE_SSL=1 -DHAVE_POSTGRESQL=1"
pg_includes_dir = fetch_pg_includes
openssl_dir = fetch_openssl_dir
swig_dir = fetch_swig_dir

cppflags = "-I#{openssl_dir}/include -I#{swig_dir} -I#{pg_includes_dir}"
ldflags = "-L#{openssl_dir}/lib -lssl -lcrypto"

puts "Using OpenSSL from: #{openssl_dir}"
puts "Using PostgreSQL from: #{pg_includes_dir}"
puts "Using SWIG from: #{swig_dir}"
puts "CXXFLAGS: #{cxxflags}"
puts "CPPFLAGS: #{cppflags}"
puts "LDFLAGS: #{ldflags}"

# Apply the flags
$CXXFLAGS += " #{cxxflags}"
$CPPFLAGS += " #{cppflags}"
$LDFLAGS  += " #{ldflags}"

create_makefile("quickfix")

Rake::ExtensionTask.new('quickfix')
