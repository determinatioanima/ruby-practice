class EventsController < ApplicationController
    before_action :set_event, :only => [ :show, :edit, :update, :destroy]
    #before_action，將Controller中重複的程式獨立出來
    def index
      #@events = Event.all
      @events = Event.page(params[:page]).per(3)
      
      respond_to do |format|
        format.html # index.html.erb
        format.xml { render :xml => @events.to_xml }
        format.json { render :json => @events.to_json }
        format.atom { @feed_title = "My event list" } # index.atom.builder
      end
    end
    
    def new
      @event = Event.new
    end
    
    def create
      @event = Event.new(event_params)
      if @event.save
        redirect_to events_url #:action => :index
        flash[:notice] = "event was successfully created"
        #在這個create Action中，使用者並沒有真的看到任何頁面
        #特殊flash變數，讓訊息可以被帶到另一個 action，它提供使用者一些有用的資訊
        #flash變數就帶著訊息到下一個Action
      else
        render :action => :new 
        #回傳new Action所使用的樣板，而不是執行new action這個方法
        #redirect_to會讓瀏覽器重新導向到new Action 失去使用者剛輸入的資料
      end
    end
    
    def show
      @page_title = @event.name
      respond_to do |format|
        format.html { @page_title = @event.name } # show.html.erb
        format.xml # show.xml.builder
        format.json { render :json => { id: @event.id, name: @event.name }.to_json }
      end
    end
    
    def edit
    end
    
    def update
      if @event.update(event_params)
        flash[:notice] = "event was successfully updated"
        redirect_to event_url(@event) #:action => :show, :id => @event
      else
        render :action => :edit
      end
    end
    
    def destroy
      @event.destroy
      flash[:alert] = "event was successfully deleted"
      redirect_to :action => :index
    end
    #Rails的程式風格非常注重變數命名的單數複數，像上述的index Action中是用@events複數命名，代表這是一個群集陣列。其他則是用@event單數命名。
    private #private以下的所有方法都會變成private方法，所以記得放在檔案的最底下。

    def set_event
      @event = Event.find(params[:id])
    end
    
    def event_params
      params.require(:event).permit(:name, :description)
    end
end
