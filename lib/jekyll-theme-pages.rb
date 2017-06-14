module Jekyll
  # Fetches and injects theme pages
  class ThemePagesGenerator < Generator
    # Safe
    safe true
    # Attributes
    attr_reader :site

    def generate(site)
      # Activated only if theme is defined
      return unless site.theme
      # Init attributes
      @site, base = site, site.theme.root

      # TODO: Find out a way to share the code
      dot_files = Dir.chdir(base) { filter_entries(Dir["*.*"], base) }
      dot_pages = dot_files.select do |file|
        Utils.has_yaml_header?(@site.in_theme_dir(base, file))
      end
      dot_static_files = dot_files - dot_pages

      retrieve_pages(base, dot_pages)
      retrieve_static_files(base, dot_static_files)
    end

    private
    # Filter out any files/directories that are hidden or backup files (start
    # with "." or "#" or end with "~"), or contain site content (start with "_"),
    # or are excluded in the site configuration, unless they are web server
    # files such as '.htaccess'.
    #
    # entries - The Array of String file/directory entries to filter.
    # base_directory - The string representing the optional base directory.
    #
    # Returns the Array of filtered entries.
    def filter_entries(entries, base_directory = nil)
      EntryFilter.new(site, base_directory).filter(entries)
    end

    # Retrieve all the pages from the current directory,
    # add them to the site and sort them.
    #
    # dir - The String representing the directory retrieve the pages from.
    # dot_pages - The Array of pages in the dir.
    #
    # Returns nothing.
    def retrieve_pages(dir, dot_pages)
      theme_pages = []
      dot_pages.each do |page|
        theme_pages << Page.new(@site, dir, "/", page)
      end
      site.pages.concat(theme_pages)
    end

    # Retrieve all the static files from the current directory,
    # add them to the site and sort them.
    #
    # dir - The directory retrieve the static files from.
    # dot_static_files - The static files in the dir.
    #
    # Returns nothing.
    def retrieve_static_files(dir, dot_static_files)
      theme_static_files = []
      dot_static_files.each do |file|
        theme_static_files << StaticFile.new(@site, dir, "/", file)
      end
      site.static_files.concat(theme_static_files)
    end
  end
end