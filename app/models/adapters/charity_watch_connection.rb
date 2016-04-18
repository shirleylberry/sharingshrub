require 'open-uri'
require 'active_support/core_ext/hash/conversions'
require 'rexml/document'
include REXML

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
    end

    def get_cause_names
      doc = Nokogiri::HTML(open(@url))
      cause_names = doc.css('div#results div.charity_title').map do |title_div|
        titleize(title_div.text)
      end
      cause_names
    end

    def get_charities
      doc = Nokogiri::HTML(open(@url))
      results_div = doc.css('div#results')
      @current_category = ""
      results_div.css('div.divider').remove
      results_div.children.each do |el|
        if el.attr("class") == 'charity_title'
          @current_category = titleize(el.text)
        elsif el.attr("class") == 'small'
          create_charity_hashes(el)
        else
          puts el.attr("class")
        end
      end
    end

    def charity_from_row(row)
      # url = row.children.children.attr("href").value
      charity_name = row.css('td').first.text
      rating = row.css('td')[1].text
      url_path = row.css('a').attr("href").value
      char_hash = {charity_name: charity_name, rating: rating, url_path: url_path, category: @current_category}
      binding.pry
    end

    def create_charity_hashes(table)
      # binding.pry
      table.children.children.each do |row|
        charity_from_row(row)
      end
    end
  end
end