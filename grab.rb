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
      content = i.inner_html.split("<br>")
      i.inner_html.split("<br>").shift
      chapter_title_preprocess = (Nokogiri::XML i.inner_html.split("<br>").first.gsub("\r\n","").strip.gsub("　","")).text == "" ? 
      i.inner_html.split("<br>").first.gsub("\r\n","").strip.gsub("　","") : (Nokogiri::XML i.inner_html.split("<br>").first.gsub("\r\n","").strip.gsub("　","")).text
      output << {"chapter_title" => chapter_title_preprocess ,
                 "chapter_content" => content.join("<br>")}
    end
    (2..page_amount).each do |i|
      base[-2] = i
      temp = Nokogiri::HTML(open(base.join("-")))
      temp.xpath("//div[starts-with(@id, 'post_')]")[1..-1].css(".t_f").each do |j|
        content = j.inner_html.split("<br>")
        j.inner_html.split("<br>").shift
        chapter_title_preprocess = (Nokogiri::XML j.inner_html.split("<br>").first.gsub("\r\n","").strip.gsub("　","")).text == "" ?
        j.inner_html.split("<br>").first.gsub("\r\n","").strip.gsub("　","") :(Nokogiri::XML j.inner_html.split("<br>").first.gsub("\r\n","").strip.gsub("　","")).text
        output << {"chapter_title"=> chapter_title_preprocess,
                   "chapter_content" => content.join("<br>")}
      end
    end
    output
  end
end
