require "ruby-progressbar"
require "json"
require "nokogiri"
require "open-uri"

class NovelGrab 
  def self.build_cache_for(page)
    all_novel = []
    progressbar = ProgressBar.create(:format => "%a %b>%i %p%% %t",
                                     :progress_mark  => '=',
                                     :remainder_mark => " ",
                                    )
    first_list_page_uri = page + "1.html"
    first_list_page = Nokogiri::HTML(open(first_list_page_uri))
    page_amount = first_list_page.css(".pg a.last").first.text.split(" ").last.to_i
    progressbar.total = page_amount
    progressbar.increment
    first_list_page.xpath("//tbody[starts-with(@id, 'normalthread_')]").each do |i|
      title = i.css(".subject .titleBox a.s")
      all_novel << {"title" => title.text ,"href" => title.attr("href").value}
    end
    
    (2..page_amount).each do |i|
      progressbar.increment
      list_page_uri = page + "#{i}.html"
      list_page = Nokogiri::HTML(open(list_page_uri))
      list_page.xpath("//tbody[starts-with(@id, 'normalthread_')]").each do |j|
        title = j.css(".subject .titleBox a.s")
        all_novel << {"title" => title.text ,"href" => title.attr("href").value}
      end
    end
    all_novel
  end
  def self.build_cache_for_long_novel
    File.open("cache/long_novel.json", "w") do |f|
      f.write(build_cache_for("https://ck101.com/forum-237-").to_json)
    end
  end
  def self.build_cache_for_short_novel
    File.open("cache/short_novel.json", "w") do |f|
      f.write(build_cache_for("https://ck101.com/forum-855-").to_json)
    end
  end
  def self.build_cache_for_finished_novel
    File.open("cache/finished_novel.json", "w") do |f|
      f.write(build_cache_for("https://ck101.com/forum-3419-").to_json)
    end
  end
  def self.build_cache_for_japanese_novel
    File.open("cache/japanese_novel.json", "w") do |f|
      f.write(build_cache_for("https://ck101.com/forum-1288-").to_json)
    end
  end
  def self.build_cache_for_danmei_novel
    File.open("cache/danmei_novel.json", "w") do |f|
      f.write(build_cache_for("https://ck101.com/forum-3446-").to_json)
    end
  end
  def self.build_cache_for_yenchin_novel
    File.open("cache/yenchin_novel.json", "w") do |f|
      f.write(build_cache_for("https://ck101.com/forum-3451-").to_json)
    end
  end
  def self.build_cache_for_published_yenchin_novel
    File.open("cache/published_yenchin_novel.json", "w") do |f|
      f.write(build_cache_for("https://ck101.com/forum-1308-").to_json)
    end
  end
  
end
