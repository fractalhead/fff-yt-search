# fff-yt-search
A search tool for finding timestamps of keywords in subtitles within the YouTube episodes from Found Footage Festival.

To Setup:
- Requires Ruby to be installed and you know how to run via command line. https://www.ruby-lang.org/en/downloads/
- Create a folder called 'text' in the same folder as search.rb (./text/)
- Requires you have .ttml subtitle files, and placed in the ./text/ folder. Highly reccommend yt-dlp. https://github.com/yt-dlp/yt-dlp
- Use "yt-dlp --skip-download --write-auto-subs --sub-format ttml {PlaylistURL}" twice inside the ./text/ folder, replacing "{PlaylistURL}" with the URLs of each the VCRParty Live and Shaturday Morning Cartoons playlists (or individual episode URLs to get the .ttml files one at a time).

To Run:
- Use 'ruby search.rb {word}'
- Replace "{word}" with the phrase or word you wish to search for. If it is a phrase and contains spaces, surround your phrase in "double-quotes"
- An HTML file 'result.html' will be generated with links to YouTube, 5 secs before the listed timestamps. Open/refresh in a browser after searches.

Tips:
- Capitalization does not matter, but punctuation does. However, only the apostrophe is currently supported.
- Keep in mind that YouTube misspells words, so search for variants.
- The subtitles are broken into small chunks of just a few words at a time, so the search looks at small segments of words and might miss your longer search phrase. So, avoid long phrases or sentences. You'll have better luck with words or phrases 1-3 words in size.
- Because the .ttml subtitle text is broken into small chunks of words, the results actually show both the chunk that matched and the previous chunk, to give better context. 
- Use spaces to ensure you don't get matches on partial words. Or leverage a lack of space to cover parts of a word. Example: " fart " instead of "fart" which matches "farther". Or use " fart" to match "farting" and "farts" as well as "fart"
- Use "," for AND. Example: " nick , joe " will match episodes where only BOTH "Nick" and "Joe" are mentioned.
- Use "|" for OR. Example: " jakesters basement | jakester's basement " covers with or without an apostrophe. Though, " jake, basement " would also do that, along with matching " jakes basement " and " jake's basement " or even " Jake's dark basement " as well... so be sure to leverage them wisely.
