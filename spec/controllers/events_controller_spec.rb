require 'spec_helper'

describe EventsController do

  # This should return the minimal set of attributes required to create a valid
  # Event. As you add validations to Event, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { name: "Graveyard Run", destination: "Forest Lawn Cemetery", arrival_time: Time.now }
  end

  before(:each) do
    user = FactoryGirl.create(:user)
    @event = FactoryGirl.create(:event, user: user)
    login_as user
  end
  
  describe "GET index" do
    it "assigns all events as @events" do
      get :index
      assigns(:events).should eq([@event])
    end
  end

  describe "GET show" do
    it "assigns the requested event as @event" do
      get :show, {:id => @event.to_param}
      assigns(:event).should eq(@event)
    end
  end

  describe "GET new" do
    it "assigns a new event as @event" do
      get :new
      assigns(:event).should be_a_new(Event)
    end
  end

  describe "GET edit" do
    it "assigns the requested event as @event" do
      get :edit, {:id => @event.to_param}
      assigns(:event).should eq(@event)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Event" do
        expect {
          post :create, {:event => valid_attributes}
        }.to change(Event, :count).by(1)
      end

      it "assigns a newly created event as @event" do
        post :create, {:event => valid_attributes}
        assigns(:event).should be_a(Event)
        assigns(:event).should be_persisted
      end

      it "redirects to the created event" do
        post :create, {:event => valid_attributes}
        response.should redirect_to(Event.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved event as @event" do
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        post :create, {:event => {}}
        assigns(:event).should be_a_new(Event)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        post :create, {:event => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested event" do
        Event.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => @event.to_param, :event => {'these' => 'params'}}
      end

      it "assigns the requested event as @event" do
        put :update, {:id => @event.to_param, :event => valid_attributes}
        assigns(:event).should eq(@event)
      end

      it "redirects to the event" do
        put :update, {:id => @event.to_param, :event => valid_attributes}
        response.should redirect_to(@event)
      end
    end

    describe "with invalid params" do
      it "assigns the event as @event" do
        Event.any_instance.stub(:save).and_return(false)
        put :update, {:id => @event.to_param, :event => {}}
        assigns(:event).should eq(@event)
      end

      it "re-renders the 'edit' template" do
        Event.any_instance.stub(:save).and_return(false)
        put :update, {:id => @event.to_param, :event => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested event" do
      expect {
        delete :destroy, {:id => @event.to_param}
      }.to change(Event, :count).by(-1)
    end

    it "redirects to the events list" do
      delete :destroy, {:id => @event.to_param}
      response.should redirect_to(events_url)
    end
  end

end
