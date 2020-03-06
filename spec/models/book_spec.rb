# frozen_string_literal: true

require "rails_helper"

RSpec.describe Book, type: :model do

  describe "Bookモデルに関するテスト" do
    describe "実際に保存してみる" do

      let!(:book_with_title_and_body){ FactoryBot.create(:book) }
      it "有効な投稿内容の場合は保存されるか" do
        expect(book_with_title_and_body).to be_persisted
      end

      let!(:book_without_title){ FactoryBot.build(:book, title: nil) }
      it "titleが空白の場合は保存されないか" do
        expect(book_without_title.valid?).to be_falsey
      end

      let!(:book_without_body){ FactoryBot.build(:book, body: nil) }
      it "Bodyが空白の場合は保存されないか" do
        expect(book_without_body.valid?).to be_falsey
      end

    end
  end
end
