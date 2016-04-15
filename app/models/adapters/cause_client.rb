module Adapters
  class CauseClient
    def create_causes(cause_names)
      # binding.pry
      cause_names.map{|name| Cause.find_or_create_by(name: name)}
      binding.pry
    end
  end
end