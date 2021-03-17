# frozen_string_literal: true

require 'ffi/hunspell'

class Spelly
  attr_accessor :dict

  def initialize(language: 'en_GB')
    @path = File.expand_path('../lib/dict', File.dirname(__FILE__))
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

  attr_accessor :path, :language

  private

  def dictionary
    @dictionary ||= FFI::Hunspell.new(path, language)
  end
end
