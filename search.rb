require "json"

class NovelGrab
  def self.search(name)
    output = []
    `ls ./cache/`.split("\n").each do |i|
      output << JSON.load(open("./cache/#{i}")).select{|x| x["title"].include? name}
    end
    output.flatten
  end
end
