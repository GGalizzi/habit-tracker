# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec, cmd: 'rspec spec', all_after_pass: false do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^(.+)\.html}) { "spec" }
  watch(%r{^lib/(.+)\.js}) { "spec" }
  watch('lib/app.js') { "spec" }
end

