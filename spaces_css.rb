#!/usr/bin/env ruby

File.open('./build/css/spaces.css', 'w') do |f|
  f.puts <<-_CSS
@charset "UTF-8";

ul {
  display: inline;
}

ul li {
  position: absolute;
  margin: 0px;
  padding: 0px;

  list-style-type: none
}

  _CSS

  f.puts <<-_CSS
#I-1 {
  left: 0px;
  top: 0px;
}

#I-2 {
  left: 100px;
  top: 100px;
}
  _CSS
end
