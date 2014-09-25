require "uri"
require "agile_utils"
require_relative "../source2pdf"
module Source2Pdf
  TMP_DIR = "source2pdf_tmp"
  # rubocop:disable ClassLength, MethodLength
  class Exporter
    attr_reader :url,
                :exts,
                :non_exts,
                :theme,
                :output_name

    attr_reader :base_dir,
                :repo_name,
                :output_path

    # The initializer for Exporter
    #
    # @param [String] url the input URL like
    #        https://github.com/opal/opal.git or just the immediate folder name
    # @param [Hash<Symbol,Object>] opts the option hash
    #
    # @option opts [Array<String>] :exts the list of file extension to be used
    # @option opts [Array<String>] :non_exts the list of file without extension to be used
    # @option opts [String]        :theme the colorscheme to use with `vim_printer`
    # @option opts [String]        :output_name the output filename if any
    def initialize(url, opts = {})
      @url         = url
      @base_dir    = Dir.pwd
      @exts        = opts[:exts]     || []
      @non_exts    = opts[:non_exts] || []
      @theme       = opts[:theme]    || "default"
      @repo_name   = project_name(url)
      @output_path = File.expand_path([base_dir, repo_name].join(File::SEPARATOR))
      @output_name = pdf_filename(opts[:output_name]) || "#{@repo_name}.pdf"
    end

    # Print and export the source from a given URL to a pdf
    def export
      clone
      puts "FYI: list of extensions: #{all_extensions}"
      puts "FYI: list of all files : #{all_files}"
      files2htmls
      htmls2pdfs
      pdfs2pdf
      copy_output
      cleanup
    end

    def to_s
      <<-EOT
        url         : #{url}
        base_dir    : #{base_dir}
        exts        : #{exts}
        non_exts    : #{non_exts}
        repo_name   : #{repo_name}
        theme       : #{theme}
        output_path : #{output_path}
        output_name : #{output_name}
     EOT
    end

    private

    def clone
      if File.exist?(output_path)
        puts "The project #{output_path} already exist, no git clone needed!"
        return
      end
      Source2Pdf.clone_repository(url, repo_name, base_dir)
    end

    # List all extensions
    def all_extensions
      all_exts = Source2Pdf.list_extensions(output_path)
      # Strip off the '.' in the output if any.
      all_exts.map! { |e| e.gsub(/^\./, "") }
      all_exts
    end

    # List all files base on simple criteria
    def all_files
      files = []
      if input_available?
        files = Source2Pdf.list_files base_dir:  output_path,
                                      exts:      exts,
                                      non_exts:  non_exts,
                                      recursive: true
      end
      files
    end

    # Convert files to htmls
    def files2htmls
      Source2Pdf.files_to_htmls base_dir: output_path,
                                exts:     exts,
                                non_exts: non_exts,
                                theme:    theme if input_available?
    end

    # Convert list of html to list of pdf files
    def htmls2pdfs
      input_file = File.expand_path("#{output_path}/vim_printer_#{repo_name}.tar.gz")
      FileUtils.mkdir_p output_dir
      AgileUtils::FileUtil.gunzip input_file, output_dir if File.exist?(input_file)
      Source2Pdf.htmls_to_pdfs base_dir: output_dir
    end

    # Merge/join multiple pdf files into single pdf
    def pdfs2pdf
      input_file = File.expand_path("#{output_dir}/html2pdf_#{repo_name}.tar.gz")
      AgileUtils::FileUtil.gunzip input_file, output_dir if File.exist?(input_file)
      Source2Pdf.pdfs_to_pdf base_dir:  output_dir,
                             recursive: true
    end

    def copy_output
      generated_file = "#{output_dir}/pdfs2pdf_#{repo_name}.pdf"
      destination_file = File.expand_path(File.dirname(output_dir) + "../../#{output_name}")
      FileUtils.mv generated_file, destination_file if File.exist?(generated_file)
      puts "Your final output is #{File.expand_path(destination_file)}"
    end

    def cleanup
      FileUtils.rm_rf File.expand_path(File.dirname(output_dir) + "../../#{Source2Pdf::TMP_DIR}")
      FileUtils.rm_rf File.expand_path(File.dirname(output_dir) + "../../#{repo_name}/vim_printer_#{repo_name}.tar.gz")
    end

    def output_dir
      File.expand_path("#{base_dir}/#{Source2Pdf::TMP_DIR}/#{repo_name}")
    end

    def input_available?
      (exts && !exts.empty?) || (non_exts && !non_exts.empty?)
    end

    # Extract project name from a given URL
    #
    # @param [String] uri input uri
    # @example
    #
    #  project_name('https://github.com/erikhuda/thor.git') #=> 'thor'
    #  project_name('https://github.com/erikhuda/thor')     #=> 'thor'
    def project_name(uri)
      name = URI(uri).path.split(File::SEPARATOR).last if uri
      File.basename(name, ".*") if name
    end

    # Add/rename the file extension to pdf
    #
    # @param [String] filename input file
    # @return [String,NilClass] output file with .pdf as extension or nil
    def pdf_filename(filename)
      return nil unless filename
      extname  = File.extname(filename)
      basename = File.basename(filename, ".*")
      if extname == ""
        "#{filename}.pdf"
      elsif extname != ".pdf"
        "#{basename}.pdf"
      else
        filename
      end
    end
  end
  # robocop:enable All
end
