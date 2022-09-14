RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render status: :ok, json: {message: "Success"}
    end
  end

  describe "handling requests" do
    context "when the request originates from an allowed domain" do
      before { @request.host = "localhost" }

      it "renders success response" do
        get :index

        expect(response).to have_http_status(:ok)
      end
    end

    context "when the request originates from an unknown domain" do
      before { @request.host = "unknown.domain" }

      it "renders forbidden response" do
        get :index

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
