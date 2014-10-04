module Source2Pdf
  CustomError = Class.new(StandardError)
  class << self
    # Clone the given repository from git repository
    #
    # @param [String] url the github repository url like 'https://github.com/schacon/ruby-git.git'
    # @param [String] name the output name to be used
    # @param [String] path the output directory
    def clone_repository(url, name, path)
      puts "git clone #{url} #{File.expand_path(path)}/#{name}"
      Git.clone url, name, path: File.expand_path(path)
    end

    def list_extensions(base_dir = ".")
      extensions = Dir.glob(File.join(File.expand_path(base_dir), "**/*")).reduce([]) do |exts, file|
        exts << File.extname(file)
      end
      extensions.sort.uniq.delete_if { |e| e == "" }
    end

    def list_files(options = {})
      CodeLister.files(options)
    end

    def files_to_htmls(opts)
      base_dir = base_dir(opts[:base_dir])
      exts     = opts[:exts]     || []
      non_exts = opts[:non_exts] || []
      args = [
        "print",
        "--base-dir",
        base_dir,
        "--exts",
        exts,
        "--theme",
        opts.fetch(:theme, "default"),
        "--recursive"
      ]
      args.concat(["--non-exts"]).concat(non_exts) unless non_exts.empty?

      puts "FYI: input options for VimPrinter : #{args}"
      VimPrinter::CLI.start(args)
    end

    # Export list of html files to pdfs using `html2pdf` gem
    def htmls_to_pdfs(opts)
      base_dir = base_dir(opts[:base_dir])
      Html2Pdf::CLI.start [
        "export",
        "--base-dir",
        base_dir,
        "--recursive"]
    end

    # Merge/combine pdfs using `pdfs2pdf` gem
    def pdfs_to_pdf(opts)
      base_dir = base_dir(opts[:base_dir])
      Pdfs2Pdf::CLI.start [
        "merge",
        "--base-dir",
        base_dir,
        "--recursive"
      ]
    end

    private

    # Always expand the directory name so that '~' or '.' is expanded correctly
    def base_dir(dir_name)
      File.expand_path(dir_name)
    end
  end
end
