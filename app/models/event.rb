class Event < ActiveRecord::Base
    validates_presence_of :name #必填欄位驗證
end
