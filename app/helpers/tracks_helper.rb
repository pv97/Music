module TracksHelper
  def ugly_lyrics(lyrics)
    split_lyrics = lyrics.split("\r\n")
    split_lyrics.map! { |line| "<pre>&#9835 #{h(line)}</pre>" }
    split_lyrics.join("").html_safe
  end
end
#
# web            html    erb
# paragraph       <p>     '<p>'.html_safe
#
# <p>             slhfs   '<p>'
