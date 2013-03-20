class Atheme::ObjectifiedHash
  def initialize(hash)
    @data = hash.inject({}) do |data, (key, value)|
      value = Atheme::ObjectifiedHash.new(value) if value.is_a? Hash

      data[key.to_s] = value
      data
    end
  end

  def method_missing(key)
    @data.key?(key.to_s) ? @data[key.to_s] : nil
  end
end
