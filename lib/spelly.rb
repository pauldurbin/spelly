# frozen_string_literal: true

require 'ffi/hunspell'

class Spelly
  attr_accessor :dict

  def initialize(language)
    @language = language
  end

  def spell_check(words)
    results = []
    words.each do |word|
      unless dictionary.check?(word)
        results << { word: word, suggest: dictionary.suggest(word) }
      end
    end
    results
  end

  attr_accessor :language

  private

  def dictionary
    @dictionary ||= FFI::Hunspell.dict(language)
  end
end
