require 'rake/extensiontask'
require 'rake_compiler_dock'

spec = eval(File.read('quickfix_ruby_ud.gemspec'))

Gem::PackageTask.new(spec) do |pkg|
end

Rake::ExtensionTask.new('quickfix', spec) do |ext|
  ext.cross_compile = true
  ext.cross_platform = %w[x86_64-linux aarch64-linux]
end

PLATFORMS = %w[
  x86_64-linux
  aarch64-linux
]


PLATFORMS.each do |plat|
  task "gem:#{plat}" do
      RakeCompilerDock.set_ruby_cc_version("~> 3.3")
      RakeCompilerDock.sh "bundle --local && rake native:#{plat} gem", platform: plat 
  end
end
