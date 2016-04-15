require 'open-uri'

module Adapters
  class CharityWatchConnection
    attr_reader :connection

    def initialize
      @connection = self.class
      @url = "https://www.charitywatch.org/top-rated-charities"
    end

    def titleize(name)
      words = name.split(/[\s,-]/)
      new_name = words.map{|word| word[0] + word.slice(1..-1).downcase}.join(" ")
      binding.pry
    end

    def get_cause_names
      doc = Nokogiri::HTML(open(@url))
      cause_names = doc.css('div#results div.charity_title').map do |title_div|
        titleize(title_div.text)
      end
      cause_names
    end

    def get_charities
    end
  end
end