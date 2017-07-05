require 'json'

class PageProvider
  def self.getResponseByPath http_path
      my_paths = JSON.parse(File.read 'paths.json')
      my_paths['paths'].each do |p|
        puts 'lookin for: ' + http_path
        if p['request'] == http_path
          fullpath = __dir__+"/pages/"+p['response']
          return File.read(fullpath)
        end
          raise StandardError
      end
  end
end
