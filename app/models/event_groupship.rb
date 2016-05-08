class EventGroupship < ActiveRecord::Base
    #Join table筆者的命名習慣會是ship結尾，用以凸顯它的關聯性質
    belongs_to :event
    belongs_to :group
end
