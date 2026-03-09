require 'rake/extensiontask'
require 'rake_compiler_dock'

spec = eval(File.read('quickfix_ruby_ud.gemspec'))

Gem::PackageTask.new(spec) do |pkg|
end

PLATFORMS = %w[
  x86_64-linux
  aarch64-linux
]

Rake::ExtensionTask.new('quickfix', spec) do |ext|
  RakeCompilerDock.set_ruby_cc_version("~> 3.4")
  ext.cross_compile = true
  ext.cross_platform = PLATFORMS
end

PLATFORMS.each do |plat|
  task "gem:#{plat}" do
    RakeCompilerDock.set_ruby_cc_version("~> 3.4")
    RakeCompilerDock.sh "bundle install && rake native:#{plat} gem", platform: plat
  end
end
