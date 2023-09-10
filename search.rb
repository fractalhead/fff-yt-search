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

def wasAndFound(isvalid, found, searchwords)
  isFound = false
  if isvalid then
    isFound = true
    searchwords.each{|sw|
      isFound &&= found[sw].nil? ? false : true  
    }
  end
  isFound
end

def wasOrFound(isvalid, found, searchwords)
  isFound = false
  if isvalid then
    searchwords.each{|sw|
      isFound ||= found[sw].nil? ? false : true  
    }
  end
  isFound
end

search_folder = "./text"
search_word = search_word.gsub("'","&#39;")
search_word_a = search_word.split(',')
search_word_o = search_word.split('|')
isOr = (search_word_o.length > 1)
isAnd = !isOr
results = {}
fname = "result.html"
url = "https://youtu.be/"
token = ""
prev = ""

File.open(fname, "w") do |file|
  file.puts "<html><head><style>BODY{color:silver;background-color:black;font-family:monospace;} A {color:#ccf;} DIV {display:block;width:700px;margin:8px auto;} H3 {color:#cfc;background-color:#333;padding:3px;} STRONG {color:#ffa;}</style></head><body>"
  Dir.glob(File.join(search_folder, "**/*.ttml")).each do |fh|
    matches = []
    found = {}
    File.readlines(fh).each{|line|
      (isOr ? search_word_o : search_word_a).each{|sw|
        line.match(/begin=\"([0-9:\.]+)\".+\>(.*#{sw}.*)\<\/p\>/i){|mline|
          matches << [mline[1], (prev+" "+mline[2]).gsub(/(#{Regexp.escape(sw)})/i,'<strong>\1</strong>')]
          found[sw] = true
        }
      }
      prev = ""
      line.match(/\>(.+)\<\/p\>/i){|pline|
        prev = pline[1]
      }
    }
    if wasOrFound(isOr, found, search_word_o) || wasAndFound(isAnd, found, search_word_a) then
      results[File.basename(fh).gsub(".en.ttml","")] = matches.clone unless matches.length == 0
    end
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
