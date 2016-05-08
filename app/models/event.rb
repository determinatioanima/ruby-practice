class Event < ActiveRecord::Base
    #dependent => :destroy @event刪除時，跟著刪除@event.location和所有@event.attendees
    has_one :location, ->{ order("id DESC") } , :dependent => :destroy # 單數 #order指定順序
    has_many :attendees, :dependent => :destroy # 複數
    has_many :event_groupships
    has_many :groups, :through => :event_groupships
    validates_presence_of :name #必填欄位驗證
    belongs_to :category
    #delegate :name, :to => :category, :prefix => true, :allow_nil => true
    accepts_nested_attributes_for :location, :allow_destroy => true, :reject_if => :all_blank
    #可以透過本來的params[:event]參數來新增或修改location
    #:allow_destroy是說我們可以在表單中多放一個_destroy核選塊來表示刪除
    #:reject_if表示說在什麼條件下，就當做沒有要真的動作
    #:all_blank就表示如果資料都是空的，就不建立location資料
end
