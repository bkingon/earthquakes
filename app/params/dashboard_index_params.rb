class DashboardIndexParams
  def self.parse(params)
    if has_filtered_params?(params)
      return DashboardIndexParams.new(params)
    end

    return NullDashboardIndexParams.new
  end

  def initialize(params)
    @params = params
  end

  def ==(other)
    other.instance_of?(self.class) &&
      other.params == params
  end

  def start_time
    params['filtered_params']['starttime']
  end

  def end_time
    params['filtered_params']['endtime']
  end

  def min_magnitude
    params['filtered_params']['minmagnitude'].to_i
  end

  protected
  attr_reader :params

  private_class_method
  def self.has_filtered_params?(params)
    params['filtered_params'].present?
  end
end

class NullDashboardIndexParams < DashboardIndexParams
  def initialize
  end

  def start_time
    Date.yesterday.to_s
  end

  def end_time
    Date.current.to_s
  end

  def min_magnitude
    0
  end
end
