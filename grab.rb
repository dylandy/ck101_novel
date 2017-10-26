require "./search"
require "nokogiri"
require "open-uri"

class NovelGrab
  def self.basic_info(book)
    output = {}
    first_page = Nokogiri::HTML(open(book["href"]))
    info_block = first_page.xpath("//div[starts-with(@id, 'post_')]").first 
    output["cover_img"] = info_block.css(".mbn img").attr("src").value
    output["intro message"] = info_block.css("table td.t_f").text.split("【其他作品】").first
    output
  end

  def self.content(book)
    output = [] 
    first_page = Nokogiri::HTML(open(book["href"]))
    base = book["href"].split("-")
    page_amount = first_page.css(".pg .last").first.text.split(" ").last.to_i
    first_page_contents = first_page.xpath("//div[starts-with(@id, 'post_')]")[1..-1].css(".t_f")
    first_page_contents.each do |i|
      content = i.text.split("<br>")
      i.text.split("<br>").shift
      output << {"chapter_title" => i.text.split("<br>").first, "chapter_content" => content.join("<br>")}
    end
    (2..page_amount).each do |i|
      base[-2] = i
      temp = Nokogiri::HTML(open(base.join("-")))
      temp.xpath("//div[starts-with(@id, 'post_')]")[1..-1].css(".t_f").each do |j|
        content = j.text.split("<br>")
        j.text.split("<br>").shift
        output << {"chapter_title"=> j.text.split("<br>").first, "chapter_content" => content.join("<br>")}
      end
    end
    output
  end
end
