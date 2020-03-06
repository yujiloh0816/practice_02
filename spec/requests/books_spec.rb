# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :request do

  describe "Bookに関するテスト" do
    it "トップ画面(root_path)に新規登録ページへのリンクが表示されているか" do
      get root_path
      expect(response.body).to include books_path
    end
  end

end