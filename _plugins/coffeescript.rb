require 'coffee-script'

module Assets
  class CoffeeFile < Jekyll::StaticFile
    def initialize(site, coffee_file)
      @site = site
      @base = site.source

      @dir = File.dirname coffee_file.path
      @name = File.basename coffee_file.path

      @coffee_file = coffee_file
    end

    def destination(dest)
      @coffee_file.destination(dest).sub 'coffee', 'js'
    end

    def write(dest)
      dest_path = destination(dest)

      FileUtils.mkdir_p(File.dirname(dest_path))

      file = File.new dest_path, 'w:UTF-8'
      file.write CoffeeScript.compile File.read @coffee_file.path

      true
    end
  end

  class CoffeeScriptCompiler < Jekyll::Generator
    def generate(site)
      coffee_files = site.static_files.select { |file| file.path[/\.coffee$/] }

      coffee_files.each do |file|
        replacement = CoffeeFile.new(site, file)

        site.static_files.delete file
        site.static_files << replacement
      end
    end
  end
end
