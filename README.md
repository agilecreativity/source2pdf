## source2pdf

[![Gem Version](https://badge.fury.io/rb/source2pdf.svg)][gem]
[![Dependency Status](https://gemnasium.com/agilecreativity/source2pdf.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/agilecreativity/source2pdf.png)][codeclimate]

[gem]: http://badge.fury.io/rb/source2pdf
[gemnasium]: https://gemnasium.com/agilecreativity/source2pdf
[codeclimate]: https://codeclimate.com/github/agilecreativity/source2pdf

Export/print content of a given git repository (or local project directory) to a single pdf for quick review offline.

### Requirements

- Valid installation of [Ghostscript][] required by [pdfs2pdf][] gem
- Valid installation of [Wkhtmltopdf][] required by [html2pdf][] gem
- Valid installation of [Vim][] required by [vim_printer][] gem

### Installation

```
gem install source2pdf
```

## Synopsis/Usage

### Basic Usage

```shell
Usage:

  $source2pdf -e, --exts=EXT1 EXT2 EXT3 -u, --url=URL -theme=theme_name --output-name=output_file.pdf

Example:

  # Export the *.rb from the given repository

  $source2pdf -e rb -u https://github.com/agilecreativity/source2pdf.git

  # Export the *.rb and also 'Gemfile' from a 'source2pdf' directory
  # Note: this directory must be directly below the current directory

  $source2pdf -e rb -f Gemfile -u source2pdf

  # Same as previous command with the 'solarized' instead of 'default' colorscheme
  $source2pdf -e rb -f Gemfile -u filename_cleaner -t solarized

Options:

  -u, --url=URL                   # The full url of the github project to be cloned OR local directory name

  -e, --exts=EXT1 EXT2 EXT3 ..    # The list of extension names to be exported
                                  # e.g. -e md rb java

  -f, [--non-exts=one two three]  # The list of file without extension to be exported
                                  # e.g. -f Gemfile LICENSE

  -t, [--theme=theme_name]        # The theme/colorscheme to be used with vim_printer see :help :colorscheme from inside Vim
                                  # default: 'default'
                                  # e.g. -t solarized

  -o, [--output-name=output.pdf]  # The output pdf filename (will default to 'repository_name'.pdf)
                                  # e.g. -o repository_name.pdf

Export a given Github project or a local project directory to a single pdf file

```

### Sample Usage:

```shell
source2pdf -u https://github.com/agilecreativity/source2pdf.git -e rb
```

Should result in something similar to this in the console

```
The project /Users/agilecreativity/Desktop/source2pdf already exist, no git clone needed!
FYI: list of extensions: ["gem", "gemspec", "lock", "md", "pdf", "png", "rb"]
FYI: list of all files : ["./lib/source2pdf.rb", "./lib/source2pdf/cli.rb", "./lib/source2pdf/source2pdf.rb", "./lib/source2pdf/exporter.rb", "./lib/source2pdf/logger.rb", "./lib/source2pdf/version.rb", "./test/lib/github_exporter/test_github_exporter.rb", "./test/test_helper.rb"]
FYI: input options for VimPrinter : ["print", "--base-dir", "/Users/agilecreativity/Desktop/source2pdf", "--exts", ["rb"], "--theme", "seoul256", "--recursive"]
FYI: process file 1 of 8 : ./lib/source2pdf.rb
FYI: process file 2 of 8 : ./lib/source2pdf/cli.rb
FYI: process file 3 of 8 : ./lib/source2pdf/source2pdf.rb
FYI: process file 4 of 8 : ./lib/source2pdf/exporter.rb
FYI: process file 5 of 8 : ./lib/source2pdf/logger.rb
FYI: process file 6 of 8 : ./lib/source2pdf/version.rb
FYI: process file 7 of 8 : ./test/lib/github_exporter/test_github_exporter.rb
FYI: process file 8 of 8 : ./test/test_helper.rb
Your output file is '/Users/agilecreativity/Desktop/source2pdf/vim_printer_source2pdf.tar.gz'
Convert file 1 of 9 : ./index.html
Convert file 2 of 9 : ./lib/source2pdf.rb.xhtml
Convert file 3 of 9 : ./lib/source2pdf/cli.rb.xhtml
Convert file 4 of 9 : ./lib/source2pdf/source2pdf.rb.xhtml
Convert file 5 of 9 : ./lib/source2pdf/exporter.rb.xhtml
Convert file 6 of 9 : ./lib/source2pdf/logger.rb.xhtml
Convert file 7 of 9 : ./lib/source2pdf/version.rb.xhtml
Convert file 8 of 9 : ./test/lib/github_exporter/test_github_exporter.rb.xhtml
Convert file 9 of 9 : ./test/test_helper.rb.xhtml
Convert files to pdfs took 8.01304 ms
Your final output is '/Users/agilecreativity/Desktop/source2pdf_tmp/source2pdf/html2pdf_source2pdf.tar.gz'
Create pdfmarks took 0.026689 ms
Combine pdf files took 0.463659 ms
Your combined pdf is available at /Users/agilecreativity/Desktop/source2pdf_tmp/source2pdf/pdfs2pdf_source2pdf.pdf
Your final output is /Users/agilecreativity/Desktop/source2pdf.pdf
```

### Sample Output

#### Using the 'default' theme/colorscheme for Vim

```shell
source2pdf -u https://github.com/agilecreativity/source2pdf.git --exts rb
```

Which generated the following [pdf output file](https://github.com/agilecreativity/source2pdf/raw/master/samples/source2pdf_default_colorscheme.pdf)

The example screenshot:

![](https://github.com/agilecreativity/source2pdf/raw/master/samples/source2pdf_default_colorscheme.png)

#### Use non-default colorscheme/theme for Vim

Use my favourite [seoul256][] colorscheme

```shell
source2pdf -u https://github.com/agilecreativity/source2pdf.git --exts rb --theme seoul256
```

Which generated the following [pdf output file](https://github.com/agilecreativity/source2pdf/raw/master/samples/source2pdf_seoul256_colorscheme.pdf)

The example screenshot:

![](https://github.com/agilecreativity/source2pdf/raw/master/samples/source2pdf_seoul256_colorscheme.png)

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[thor]: https://github.com/erikhuda/thor
[minitest]: https://github.com/seattlerb/minitest
[yard]: https://github.com/lsegal/yard
[pry]: https://github.com/pry/pry
[rubocop]: https://github.com/bbatsov/rubocop
[grit]: https://github.com/mojombo/grit
[Ghostscript]: http://ghostscript.com/doc/current/Install.htm
[Wkhtmltopdf]: https://github.com/pdfkit/pdfkit/wiki/Installing-WKHTMLTOPDF
[Vim]: http://www.vim.org
[vim_printer]: https://github.com/agilecreativity/vim_printer
[pdfs2pdf]: https://github.com/agilecreativity/pdfs2pdf
[html2pdf]: https://github.com/agilecreativity/html2pdf
[monokai]: https://github.com/lsdr/monokai
[seoul256]: https://github.com/junegunn/seoul256.vim
