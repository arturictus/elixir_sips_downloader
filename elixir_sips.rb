require 'mechanize'
require 'pry'
class Settings
  attr_reader :hash
  def initialize
    path = File.expand_path('settings.yml', __dir__)
    @hash = YAML.load(File.read(path))
  end

  def [](key)
    hash[key]
  end
end

class SipsDown < Mechanize
  def secrets
    @secrets ||= Settings.new
  end
  def login
    puts 'Login in...'
    login_page = get('https://elixirsips.dpdcart.com/subscriber/logout')
    login_form = login_page.forms.first
    login_form.username = secrets['username']
    login_form.password = secrets['password']
    @list_page = submit(login_form, login_form.buttons.first)
  end

  def list_page
    @list_page ||= login
  end

  def show_links
    @show_links ||= list_page.links_with(href: /\/subscriber\/post\?id=\d+#files/).reverse
  end

  def download
    show_links.each do |link|
      transact do
        show = ShowPage.new(click(link), secrets)
        puts "Inside ShowPage #{show.title}"
        show.files_to_download.each do |stupdi_file|
          local_file = ::File.join(show.folder, stupdi_file.text)
          if ::File.exist?(local_file)
            puts "File Already exists #{local_file}"
            next
          end
          dowload_file(
            show.folder,
            stupdi_file,
            stupdi_file.text
          )
        end
      end
    end
  end
  private

  def dowload_file(folder, link, file_name)
    unless ['.markdown', '.mp4', '.md', '.tar.gz', '.txt'].any?{ |ext| file_name.include?(ext) }
      puts "Skiping file: #{file_name}"
      return
    end
    unless Dir.exists?(folder)
      puts "Creating folder #{folder}"
      FileUtils.mkdir_p(folder)
    end
    puts "Downloading #{file_name}"
    file = click(link)
    file.save("#{folder}/#{file_name}")
    puts "Download FINISHED_________________________________________________"
  end

end
class ShowPage < Struct.new(:page, :secrets)
  def title
    page.title
  end
  def files_to_download
    page.links_with(href: /\/subscriber\/download\?file_id=\d/)
  end

  def folder
    File.join(secrets['download_folder'], title).gsub(' | Elixir Sips', '')
  end
end

class ElixirSips
  attr_reader :folder, :session
  def initialize(folder, opts = {})
    @folder = folder
    @session = SipsDown.new
  end

  def list_page
    session.list_page
  end

  def download
    session.download
  end
end
