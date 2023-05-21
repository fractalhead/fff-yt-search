# fff-yt-search
A search tool for finding timestamps of keywords in subtitles within the YouTube episodes from Found Footage Festival.

To Setup:
- Requires Ruby to be installed and you know how to run via command line.
- Create a folder called 'text' in the same folder as search.rb (./text/)
- Requires yt-dlp to download .ttml subtitle files, and placed in the ./text/ folder.
- Use "yt-dlp --skip-download --write-auto-subs --sub-format ttml {PlaylistURL}" twice inside the ./text/ folder, replacing "{PlaylistURL}" with the URLs of each the VCRParty Live and Shaturday Morning Cartoons playlists (or individual episode URLs to get the .ttml files one at a time).

To Run:
- Use 'ruby search.rb {word}'
- Replace "{word}" with the phrase or word you wish to search for. If it is a phrase and contains spaces, surround your phrase in "double-quotes"
- An HTML file 'result.html' will be generated with links to YouTube, 5 secs before the listed timestamps. Open/refresh in a browser after searches.

Tips:
- Keep in mind that YouTube misspells words, so search for variants.
- The subtitles are broken into small chunks of just a few words at a time, so the search looks at small segments of words and might miss your longer search phrase. So, avoid long phrases or sentences. You'll have better luck with words or phrases 1-3 words in size.
- Because the .ttml subtitle text is broken into small chunks of words, the results actually show both the chunk that matched and the previous chunk, to give better context. 
- Do not use punctuation other than an apostrophe like in "I'll" or "can't."
