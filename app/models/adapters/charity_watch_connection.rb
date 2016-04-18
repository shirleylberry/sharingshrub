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
      new_name = words.map{|word| word[0] + word.slice(1..-1).downcase unless word.empty? }.join(" ")
    end

    def get_cause_names
      doc = Nokogiri::HTML(open(@url))
      cause_names = doc.css('div#results div.charity_title').map do |title_div|
        titleize(title_div.text)
      end
      cause_names
    end

    def get_charities
      @charities = []
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
        # puts el.text, @charities
      end
      @charities
    end

    def charity_from_row(row)
      # url = row.children.children.attr("href").value
      charity_name = row.css('td').first.text
      rating = row.css('td')[1].text
      url_path = row.css('a').attr("href").value
      char_hash = {name: charity_name, rating: rating, url_path: url_path, category: @current_category}
    end

    def create_charity_hashes(table)
      table.children.children.each do |row|
        hash = charity_from_row(row)
        new_hash = specific_charity_data(hash)
        @charities.push(new_hash)
      end
    end

    def specific_charity_data(charity_hash)
      @charity_url = "https://www.charitywatch.org" + charity_hash[:url_path]
      doc = Nokogiri::HTML(open(@charity_url))
      c_info_div = doc.at_css('.charity_row .charity_section').children
      address = [c_info_div[5], c_info_div[7], c_info_div[9]].join(" ")
      website = c_info_div[11].attr("href")
      mission = doc.css('.charity_row .charity_section')[3].text.gsub(/[\t\n]/, "").gsub("Stated Mission ", "")
      charity_hash[:website] = website
      charity_hash[:address] = address
      charity_hash[:mission] = mission
      charity_hash
    end
  end
end