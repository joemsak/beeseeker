class SearchableList
  def self.query(options)
    options.flat_map do |attribute, value|
      send("search_by_#{attribute}", value)
    end
  end

  def self.search_by_zipcode(zipcode)
  end
end
