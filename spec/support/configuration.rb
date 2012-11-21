class Kris::Kross::Configuration
  def self.reset
    @origins = nil
    @hosts = nil
    @headers = nil
    reset_instance
  end
end
