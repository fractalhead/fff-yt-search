#!/usr/bin/env ruby

search_word = ARGV[0].chomp
puts "Searching For: '#{search_word}'"

def getSeconds(time)
  secs = 0
  time.split(':').each{|t| 
    secs += t.to_i
    secs *= 60 
  }
  ((secs/60)-5).to_s
end

search_folder = "./text"
search_word = search_word.gsub("'","&#39;")
results = {}
fname = "result.html"
url = "https://youtu.be/"
token = ""
prev = ""

File.open(fname, "w") do |file|
  file.puts "<html><head><style>BODY{color:silver;background-color:black;font-family:monospace;} A {color:#ccf;} DIV {display:block;width:700px;margin:8px auto;} H3 {color:#cfc;background-color:#333;padding:3px;} STRONG {color:#ffa;}</style></head><body>"
  Dir.glob(File.join(search_folder, "**/*.ttml")).each do |fh|
    matches = []
    File.readlines(fh).each{|line|
      line.match(/begin=\"([0-9:\.]+)\".+\>(.*#{search_word}.*)\<\/p\>/i){|mline|
        matches << [mline[1], (prev+" "+mline[2]).gsub("#{search_word}","<strong>#{search_word}</strong>")]
      }
      prev = ""
      line.match(/\>(.+)\<\/p\>/i){|pline|
        prev = pline[1]
      }
    }
    results[File.basename(fh).gsub(".en.ttml","")] = matches.clone unless matches.length == 0
  end
  results.each_key{|key|
    file.puts "<div><h3>#{key}</h3>"
    key.match(/\[(.+)\]/i){|t| token = t[1] }
    results[key].each{|item| file.puts "  <a href=\"#{url+token+"?t="+getSeconds(item[0])}\" target=\"_blank\">#{item[0]}</a> - #{item[1].gsub("&#39;","'")}<br/>"}
    file.puts "</div>"
  }
  file.puts "</body></html>"
end
puts "Found In #{results.size} Episodes => #{fname} Updated."