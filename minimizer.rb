###
#
# minimizer.rb
# Initialize the class with any name you would like, and the path to the folder
# that needs minimized. All files within the source directory will be
# moved into one single folder that will include a date stamp
#
###


class Minimizer
  require 'fileutils'

  attr_accessor :name, :path

  # Path can't use ~
  def initialize(name, f_path)
    @name = name
    @path = f_path
    minimize_files
  end

  private

  def minimize_files
    puts "Source Directory: #{@path}"
    time = Time.now.strftime("%Y-%m-%d")
    dest_dir = @path + "/#{@name}_minimized_#{time}"

    unless File.directory?(dest_dir)
      puts "Destination directory does not exist."
      puts "Creating #{dest_dir}"
      FileUtils.mkdir_p(dest_dir)
    end

    count = Dir.entries(@path).count

    Dir.entries(path).select {|f|
      source_file = @path + "/" + f
      unless f == "." || f == ".." || source_file == dest_dir
        puts "#{source_file} -> #{dest_dir}/#{f}"
        FileUtils.mv(source_file, dest_dir)
      end
    }

    puts "Destination directory: #{dest_dir}"
    puts "#{count} items minimized"
  end
end
