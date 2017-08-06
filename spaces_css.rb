#!/usr/bin/env ruby

require 'yaml'

dimensions = YAML.load_file('src/dimensions.yaml')
SPACE_WIDTH  = dimensions[:SPACE_WIDTH]
SPACE_HEIGHT = dimensions[:SPACE_HEIGHT]
ISLE_WIDTH   = dimensions[:ISLE_WIDTH]
ISLE_HEIGHT  = dimensions[:ISLE_HEIGHT]

def is_birthday_space?(col_num, col_length, space_idx)
  (col_num == 0 && space_idx == 0) || (col_num == 1 && space_idx == col_length - 1)
end

def birthday_space_height
  (SPACE_WIDTH + SPACE_HEIGHT) / 2 # horizontal
end

def height_for(col_num, col_length, space_idx, initial)
  ((is_birthday_space?(col_num, col_length, space_idx) || is_birthday_space?(col_num, col_length, space_idx + 1)) ? birthday_space_height : SPACE_HEIGHT) -
  (initial =~ /[M-Zあ-おせ-ほ]/ ? 0.7 : initial =~ /[か-せま]/ ? 0.35 : 0)
end

blocks = YAML.load_file('src/blocks.yaml')

# positions of each spaces
spaces_positions = {}

blocks.each do |initial, block|
  space_number = 1

  block[:islands].each_with_index do |row, i|
    offset_x = (SPACE_WIDTH * 2 + ISLE_WIDTH) * i - SPACE_WIDTH / 2 + 4
    offset_y = SPACE_HEIGHT * (block[:islands].first.first - row.first) + SPACE_HEIGHT - 6

    last_height = 0 # YUCK

    # go upward the island
    row.each_with_index do |col_length, col_num|
      col_length.times do |space_idx|
        spaces_positions[initial + '-' + "%02d" % space_number] = {
          :x => block[:position][:x] + offset_x + (is_birthday_space?(col_num, col_length, space_idx) ? SPACE_WIDTH / 2 : 0), # center "birthday" space
          :y => block[:position][:y] - offset_y,
        }
        space_number += 1
        offset_y += height_for(col_num, col_length, space_idx, initial)
        last_height = height_for(col_num, col_length, space_idx, initial) # YUCK
      end
      offset_y += ISLE_HEIGHT
    end

    offset_x += SPACE_WIDTH
    offset_y -= last_height + ISLE_HEIGHT # almost makes me vomit

    # go downward the island
    row.reverse.each_with_index do |col_length, col_num|
      col_length.times do |space_idx|
        unless is_birthday_space?(col_num, col_length, space_idx) # skip "birthday" space
          spaces_positions[initial + '-' + "%02d" % space_number] = {
            :x => block[:position][:x] + offset_x,
            :y => block[:position][:y] - offset_y,
          }
          space_number += 1
        end
        offset_y -= height_for(col_num, col_length, space_idx, initial)
      end
      offset_y -= ISLE_HEIGHT
    end
  end
end

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

  list-style-type: none;
  color: red;
  font-size: 8pt;
}

  _CSS

  spaces_positions.each do |space, position|
    f.puts <<-_CSS
##{space}, ##{space}a, ##{space}b {
  left: #{position[:x]}px;
  top: #{position[:y]}px;
}
    _CSS
  end
end
