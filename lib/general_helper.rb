module GeneralHelper
  module Convertions
    def to_minutes(seconds)
      m = (seconds/60).floor
      s = (seconds - (m * 60)).round

      # add leading zero to one-digit minute
      if m < 10
        m = "0#{m}"
      end
      # add leading zero to one-digit second
      if s < 10
        s = "0#{s}"
      end
      # return formatted time
      return "#{m}:#{s}"
    end # to_minutes

    def to_whole_minutes(seconds)
      to_minutes(seconds).split(':')[0].to_i
    end # to_whole_minutes

  end # Convertions
end # GeneralHelper