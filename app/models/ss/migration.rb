class SS::Migration
  include Mongoid::Document

  field :version, type: String

  DIR = Rails.root.join('lib/migrations')

  class << self
    # Do migration.
    def migrate
      filepaths_to_apply.each do |filepath|
        timestamp = take_timestamp filepath
        require filepath
        "SS::Migration#{timestamp}".constantize.new.change
        create version: timestamp
        puts "Applied SS::Migration#{timestamp}"
      end
    end

    # Return the all filepaths in *RAILS_ROOT/lib/migrations/**.
    #
    # Returned array is sorted ascending by the filename.
    #
    # @return [Array<String>] An array of sorted filepathe strings.
    #
    # @example It returns an array of filepath strings.
    #   # Directory structure
    #
    #   # + /foo/bar/lib/migrations/
    #   #   + mod1/
    #   #     - 20150324000001_a.rb
    #   #     - 20150324000002_a.rb
    #   #   + mod2/
    #   #     - 20150324000000_a.rb
    #   #     - 20150324000003_a.rb
    #
    #   SS::Migration.filepaths
    #   #=>
    #   # ['/foo/bar/lib/migrations/mod2/20150324000000_a.rb',
    #   #  '/foo/bar/lib/migrations/mod1/20150324000001_a.rb',
    #   #  '/foo/bar/lib/migrations/mod1/20150324000002_a.rb',
    #   #  '/foo/bar/lib/migrations/mod2/20150324000003_a.rb',]
    def filepaths
      ::Dir.glob(DIR.join('*/*')).sort_by { |i| File.basename i }
    end

    # Returns the latest applied migration version string.
    # If there is no applied migration, it returns "00000000000000".
    #
    # @return [String] The latest applied migration version string or "00000000000000".
    #
    # @example
    #   SS::Migration.latest_version #=> '20150330000000'
    def latest_version
      x = order(version: -1).limit(1).first
      x.nil? ? '00000000000000' : x.version
    end

    # Take a timestamp from a filepath.
    #
    # @param [String] filepath
    #
    # @return [String] timestamp
    #
    # @example
    #   SS::Migration.take_timestamp '/foo/bar/lib/migrations/mod1/20150330000000_a.rb'
    #   #=> '20150330000000'
    def take_timestamp(filepath)
      File.basename(filepath).split('_')[0]
    end

    # Return the all filepath of migrations to apply.
    #
    # It is a sub array of *filepaths* method.
    #
    # @return [Array<String>] An array of filepath of migrations to apply.
    def filepaths_to_apply
      filepaths.select { |e| take_timestamp(e) > latest_version }
    end
  end
end
