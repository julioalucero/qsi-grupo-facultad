namespace :feeds do

  desc "Feeds load all"
  task :load_all => :environment do
    begin
      feeds = Feed.fetch_feeds
      puts "feeds loaded: #{feeds.count}"
      puts "feeds on DB : #{Feed.count}"
      puts "-" * 20
    end while feeds.any?
  end
end
