require 'less'

module Assets
  class LessFile < Jekyll::StaticFile
    def initialize(site, less_file)
      @site = site
      @base = site.source

      @dir = File.dirname less_file.path
      @name = File.basename less_file.path

      @less_file = less_file
    end

    def destination(dest)
      @less_file.destination(dest).sub 'less', 'css'
    end

    def write(dest)
      dest_path = destination(dest)

      parser = Less::Parser.new :filename => dest_path
      tree = parser.parse File.read @less_file.path

      FileUtils.mkdir_p(File.dirname(dest_path))

      file = File.new dest_path, 'w:UTF-8'
      file.write tree.to_css

      true
    end
  end

  class LessCompiler < Jekyll::Generator
    def generate(site)
      less_files = site.static_files.select { |file| file.path[/\.less$/] }

      less_files.each do |file|
        replacement = LessFile.new(site, file)

        site.static_files.delete file
        site.static_files << replacement
      end
    end
  end
end
