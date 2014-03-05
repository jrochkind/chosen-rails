require 'thor'
require 'json'
require 'open-uri'

require 'rubygems/package'
require 'zlib'

class ChosenAssets::SourceFetcher
  GithubRepo = 'harvesthq/chosen'

  def initialize(github_repo, tag_name = nil)
    @github_repo = github_repo || GithubRepo
    @tag_name = tag_name
  end

  #desc 'fetch source files', 'fetch source files from GitHub'
  def fetch
    releases_data = JSON.load( open("https://api.github.com/repos/#{@github_repo}/releases") )
    release = if @tag_name.nil? 
      releases_data.first
    else
      releases_data.find {|hash| hash["tag_name"] == @tag_name}
    end

    # We assume there's only one asset, and we want it
    asset       = release['assets'].first
    asset_name  = asset['name']

    local_zip_path = "tmp/#{asset_name}"
    
    open(local_zip_path, "wb") do |file|
      # Need to send Accept  application/octet-stream to github to get the binary
      # http://developer.github.com/v3/repos/releases/#get-a-single-release-asset
      file << open(asset['url'], "Accept" => "application/octet-stream").read
    end

    # We're just gonna shell out to the 'unzip' command, OSX and unix prob
    # has it, good enough. 
    local_source_path = "tmp/#{asset_name.chomp(File.extname(asset_name))}"
    system("unzip", local_zip_path, "-d", local_source_path)

    # Copy all the files over

    
    Dir.glob("#{local_source_path}/*.css").each do |source|
      FileUtils.copy source, "vendor/assets/stylesheets/#{File.basename source}"
    end

    Dir.glob("#{local_source_path}/*.js").each do |source|
      FileUtils.copy source, "vendor/assets/javascripts/#{File.basename source}"
    end

    Dir.glob("#{local_source_path}/*.{png,gif,jpg,jpeg}").each do |source|
      FileUtils.copy source, "vendor/assets/images/#{File.basename source}"
    end


  end


  protected
  def untar(source_path)
    
  tar_extract = Gem::Package::TarReader.new(Zlib::GzipReader.open(source_path))
  tar_extract.rewind # The extract has to be rewinded after every iteration
  tar_extract.each do |entry|
    puts entry.full_name
    puts entry.directory?
    puts entry.file?
    # puts entry.read
  end
  tar_extract.close
  end

end