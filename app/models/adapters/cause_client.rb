module Adapters
  class CauseClient
    def create_causes(cause_names)
      cause_names.map{|name| Cause.find_or_create_by(name: name)}
    end
  end
end