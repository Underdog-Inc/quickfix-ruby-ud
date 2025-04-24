require 'mkmf'
require 'open3'

dir_config('quickfix', ['.'], '.')

# Helpers to fetch config values
def fetch_pg_include_dir
  return ENV['PG_INCLUDE_DIR'] if ENV['PG_INCLUDE_DIR'] && Dir.exist?(ENV['PG_INCLUDE_DIR'])
  
  stdout, _ = Open3.capture2('pg_config --includedir')
  stdout.strip
end

def fetch_openssl_dir
  # Allow environment override
  return ENV['OPENSSL_DIR'] if ENV['OPENSSL_DIR'] && Dir.exist?(ENV['OPENSSL_DIR'])

  # Try pkg-config
  begin
    stdout, status = Open3.capture2('pkg-config', '--variable=prefix', 'openssl')
    return stdout.strip if status.success? && Dir.exist?(stdout.strip)
  rescue Errno::ENOENT
    # pkg-config not available
  end

  # Try brew on macOS
  if RbConfig::CONFIG['host_os'] =~ /darwin/ && system('which brew > /dev/null')
    begin
      stdout, status = Open3.capture2('brew', '--prefix', 'openssl')
      return stdout.strip if status.success? && Dir.exist?(stdout.strip)
    rescue Errno::ENOENT
      # brew not available
    end
  end

  # Fallback to common paths
  fallback_paths = %w[
    /usr/local/opt/openssl@3
    /usr/local/opt/openssl
    /usr/local/ssl
    /usr/lib/ssl
    /opt/homebrew/opt/openssl@3
    /opt/homebrew/opt/openssl
    /opt/openssl
  ]

  fallback_paths.each do |path|
    return path if Dir.exist?(path)
  end

  raise 'OpenSSL directory not found. Please set OPENSSL_DIR environment variable.'
end

# Set flags
# TODO(tckerr) confirm -std=c++20 isn't needed (it broke compilation on the linux targets)
cxxflags = '-std=c++2a -DHAVE_SSL=1 -DHAVE_POSTGRESQL=1'
pg_include_dir = fetch_pg_include_dir
openssl_dir = fetch_openssl_dir

cppflags = "-I#{openssl_dir}/include -I#{pg_include_dir}"

# TODO(tckerr) confirm -lssl and -lcrypto aren't needed (they broke compilation on the linux targets)
ldflags = "-L#{openssl_dir}/lib"

puts "Using OpenSSL from: #{openssl_dir}"
puts "Using PostgreSQL from: #{pg_include_dir}"
puts "CXXFLAGS: #{cxxflags}"
puts "CPPFLAGS: #{cppflags}"
puts "LDFLAGS: #{ldflags}"

# Apply the flags
$CXXFLAGS += " #{cxxflags}"
$CPPFLAGS += " #{cppflags}"
$LDFLAGS  += " #{ldflags}"

create_makefile('quickfix')
