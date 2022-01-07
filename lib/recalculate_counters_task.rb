# frozen_string_literal: true

class RecalculateCountersTask

  def initialize(master, slave)
    @master_class = master.camelize.constantize  # Post
    @slave_class  = slave.camelize.constantize   # Comment
    @slaves       = "#{slave.pluralize}".to_sym  # :comments
  end

  def run
    reset_column_info
    reset_counters
  end

  private

  def reset_column_info
    puts "\nResetting column information\n"
    @master_class.reset_column_information
  end

  def reset_counters
    @master_class.pluck(:id).each do |id|
      puts "Resetting #{@slaves} counters for #{@master_class} #{id}"
      @master_class.reset_counters(id, @slaves)
    end
  end

end
