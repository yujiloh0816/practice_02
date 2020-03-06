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

    context 'bookを投稿' do
      let!(:book_attributes) { FactoryBot.attributes_for(:book) }

      it '正しく保存できているか' do
        expect { post books_path, params: { book: book_attributes } }.to \
          change(Book, :count).by(1)
      end

      it 'リダイレクト先は正しいか' do
        post books_path, params: { book: book_attributes }
        expect(response).to redirect_to book_path(Book.last)
      end

      it 'サクセスメッセージは正しく表示されるか' do
        post books_path, params: { book: book_attributes }
        expect(flash[:notice]).to eq 'Book was successfully created.'
      end
    end

    context 'bookの更新' do
      let!(:book_attributes) { FactoryBot.attributes_for(:book) }

      it 'bookが更新されているか' do
        expect { put book_path(book), params: { book: book_attributes } }.to_not \
          change(Book, :count)
      end

      it 'リダイレクト先は正しいか' do
        put book_path(book), params: { book: book_attributes }
        expect(response).to redirect_to book_path(book)
      end

      it 'サクセスメッセージは正しく表示されるか' do
        put book_path(book), params: { book: book_attributes }
        expect(flash[:notice]).to eq 'Book was successfully updated.'
      end
    end

    context 'bookの削除' do

      it 'bookが削除されているか' do
        expect { delete book_path(book) }.to change(Book, :count).by(-1)
      end

      it 'リダイレクト先は正しいか' do
        delete book_path(book)
        expect(response).to redirect_to books_path
      end
    end
  end
end
