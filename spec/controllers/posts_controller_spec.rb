RSpec.describe PostsController, type: :controller do
    let!(:user) { build(:user, title: "title", body: "bodyText") }

login_user

  it "should have a current_user" do
    expect(subject.current_user).to_not eq(nil)
  end

  describe 'GET #new' do
    it "should find current_user and open form for create Post" do
      get :new
      expect(subject.current_user.email).to eq("balogh.sandor021@gmail.com")
      expect(subject.current_user.email).to_not eq(user.email)
      expect(response).to have_http_status(200)     
    end
  end

    describe 'POST #create' do
    it "should create Post" do
      post :create, params: {post: {title:"title", body: "bodyText"}}
      expect(subject.current_user.post.title).to eq("title")
      expect(subject.current_user.post.body).to eq("bodyText")
      expect(response).to redirect_to root_path
    end
  end

  describe 'GET #edit' do
    it "should find current_user and open form for edit Post" do
      get :edit, xhr: true, format: :js, params: {id: subject.current_user.id}
      expect(subject.current_user.email).to eq("balogh.sandor021@gmail.com")
      expect(subject.current_user.email).to_not eq(user.email)
      expect(response).to have_http_status(200)
    end
  end

  
  describe 'PATCH #update' do
   before do
      @userparam = create(:userparam, user_id: subject.current_user.id)
    end  
    it "should update userparam and redirect to userparam" do
      patch :update, params: { id: subject.current_user.id, userparam: {title:"titleU", body: "bodyTextU"}}
      expect(subject.current_user.post.title).to eq("titleU")
      expect(subject.current_user.post.body).to eq("bodyTextU")
      expect(response).to redirect_to post_path
    end
  end


end