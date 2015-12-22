###
#
# minimizer.rb
# initialize the class 


class Minimizer
  require 'fileutils'

  attr_accessor :name, :path

  # Path can't use ~
  def initialize(name, f_path)
    @name = name
    @path = f_path
    move_files
  end

  private

  def move_files
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
