module Adapters
  class CharityClient
    def create_charities(charity_hashes)
      charity_hashes.each do |hash|
        hash.delete(:url_path)
        cause_name = hash.delete(:cause)
        cause = Cause.find_or_create_by(name: cause_name)
        c = Charity.create(hash)
        c.causes.push(cause)
        # binding.pry
      end
    end
  end
end