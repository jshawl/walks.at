# Pin npm packages by running ./bin/importmap

Dir.glob("app/javascript/**/*").select do |entry|
  entry.ends_with? ".js"
end.map do |entry|
  entry.gsub(/app\/javascript\/(.*).js/, '\1')
end.map do |entry|
  pin entry
end
