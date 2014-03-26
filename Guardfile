# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec, cmd: 'rspec spec' do
  watch(%r{^spec/.+_spec\.rb$}) { "spec" }
  watch(%r{^(.+)\.html}) { "spec" }
end

