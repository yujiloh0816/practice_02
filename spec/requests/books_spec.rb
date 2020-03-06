# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :request do

  describe 'Bookに関するテスト' do
    let!(:book) { FactoryBot.create(:book) }

    it 'トップ画面(root_path)に新規登録ページへのリンクが表示されているか' do
      get root_path
      expect(response.body).to include books_path
    end

    context 'bookの一覧ページの表示とリンクは正しいか' do

      it 'bookの一覧表示(tableタグ)と投稿フォームが同一画面に表示されているか', :aggregate_failures do
        get books_path
        expect(response.body).to include '<table>'
        expect(response.body).to include '<form action="/books"'
      end

      it 'bookのタイトルと感想を表示し、詳細・編集・削除のリンクが表示されているか', :aggregate_failures do
        get books_path
        expect(response.body).to include book_path(book)
        expect(response.body).to include edit_book_path(book)
        expect(response.body).to include 'data-method="delete" href="/books/'
      end
    end

    context 'bookの詳細ページへの表示内容とリンクは正しいか' do

      it 'bookの詳細内容と新規登録、編集ページのリンクが表示されているか', :aggregate_failures do
        get books_path(book)
        expect(response.body).to include books_path
        expect(response.body).to include edit_book_path(book)
      end
    end

  end

end