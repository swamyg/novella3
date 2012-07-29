module ChaptersHelper
  def parse_for_characters(content, novel)
    mentioned_characters = content.scan(/\{(\w+)\}/)
    parsed_content = content
    mentioned_characters.each do |char|
      character_name = char.first
      puts "NAME IS ----> #{character_name}"
      character = Character.find_by_name(character_name)
      char_link = link_to character.name, novel_character_path(novel.perma_link, character.id), :class => 'normal'
      parsed_content.gsub!(/\{#{character.name}\}/, char_link)
    end
    parsed_content
  end
end
