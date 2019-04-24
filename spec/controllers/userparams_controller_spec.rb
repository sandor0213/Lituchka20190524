require 'rails_helper'

RSpec.describe UserparamsController, type: :controller do
    let!(:user) { build(:user, firstname: "Sandor", lastname: "Balogh", age: 24) }

login_user

  it "should have a current_user" do
    expect(subject.current_user).to_not eq(nil)
  end

  describe 'GET #new' do
    it "should find current_user and open form for create Useraparm" do
      get :new
      expect(subject.current_user.email).to eq("balogh.sandor0213@gmail.com")
      expect(subject.current_user.email).to_not eq(user.email)
      expect(response).to have_http_status(200)     
    end
  end

  describe 'POST #create' do
    it "should create Userparam" do
      post :create, params: {userparam: {firstname:"SandorCreated", lastname: "BaloghCreated", age: 24}}
      expect(subject.current_user.userparam.firstname).to eq("SandorCreated")
      expect(subject.current_user.userparam.lastname).to eq("BaloghCreated")
      expect(subject.current_user.userparam.age).to eq(24)
      expect(response).to redirect_to root_path
    end
  end

  describe 'GET #edit' do
    it "should find current_user and open form for edit Userparams" do
      get :edit, xhr: true, format: :js, params: {id: subject.current_user.id}
      expect(subject.current_user.email).to eq("balogh.sandor0213@gmail.com")
      expect(subject.current_user.email).to_not eq(user.email)
      expect(response).to have_http_status(200)
    end
  end
  
  describe 'PATCH #update' do
   before do
      @userparam = create(:userparam, user_id: subject.current_user.id)
    end  
    it "should update userparam and redirect to userparam" do
      patch :update, params: { id: subject.current_user.id, userparam: {firstname: "SandorUpd", lastname: "BaloghUpd", age: 34}}
      expect(subject.current_user.userparam.firstname).to eq("SandorUpd")
      expect(subject.current_user.userparam.lastname).to eq("BaloghUpd")
      expect(subject.current_user.userparam.age).to eq(34)
      expect(response).to redirect_to userparams_path
    end
  end

end