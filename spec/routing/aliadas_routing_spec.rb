require "rails_helper"

RSpec.describe AliadasController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/aliadas").to route_to("aliadas#index")
    end

    it "routes to #new" do
      expect(get: "/aliadas/new").to route_to("aliadas#new")
    end

    it "routes to #show" do
      expect(get: "/aliadas/1").to route_to("aliadas#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/aliadas/1/edit").to route_to("aliadas#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/aliadas").to route_to("aliadas#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/aliadas/1").to route_to("aliadas#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/aliadas/1").to route_to("aliadas#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/aliadas/1").to route_to("aliadas#destroy", id: "1")
    end
  end
end
