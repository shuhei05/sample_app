# frozen_string_literal: true

require 'rails_helper'

describe'投稿のテスト'do
 let!(:list) {creata(:list, title:'hoge',body:'body')}
 describe'トップ画面(top_path)のテスト'do
   before do
     vist top_path
    end
    context'表示の確認'
    it'トップ画面(top_path)にここはTopページですが表示されているか'do
      expect(page).to have_content'ここはトップページです'
    end
    it'top_pathが"/top"であるか'do
      expect(current_path).to eq('/top')
    end
  end

describe'投稿画面のテスト'do
  before do
    visit todolists_new_path
  end
  context'表示の確認'do
  it'todolists_new_pathが"/todolists_/new"であるか'do
    expect(current_path).to eq('/todolists/new')
  end
end

  context'表示の確認'do
  it'投稿ボタンが表示されているかどうか'do
  expect(page).to have_button '投稿'
  end
end
end

  context'投稿処理のテスト'do
  it'投稿後のリダイレクト先は正しいか'do
   fill_in'list[title]',with:Faker::Lorem.characters(number:5)
   fill_in'lists[body]',with:Faker::Lorem.characters(number:20)
   click_button'投稿'
   expect(page).to have_current_path todolist_path(List.last)
   end
 end

describe'一覧画面のテスト'do
before do
  visit todolists_path
end
context'一覧画面の表示とリンクの確認'do
  it'一覧画面に投稿されたものの表示されているか'do
    expect(page).to have _content list.title
    expect(page).to have_link list.title
  end
 end
end

describe'詳細画面のテスト'do
before do
  visit todolist_path(list)
end

context'表示のテスト'do
  it'削除リンクが存在しているか'do
    expect(page).to have_link '削除'
  end
  it'編集リンクが存在しているか'do
    expect(page).to have_link '編集'
  end
end

context'リンクの遷移先の確認'do
  it'編集の遷移先は編集画面か'do
    edit_link = find_all('a')[0]
    edit_link.click
    expect(current_path).to eq('/todolists/'+list.id.to_s+'/edit')
  end
end

contexe'listの削除のテスト'do
  it'listの削除'do
    expect{list.destory}.to change{List.count}.by(-1)
  end
end
end

describe'編集画面のテスト'do
  befor do
    visit edit_todolist_path
  end
  context'表示の確認'do
   it'遷移前のタイトルと本文がフォームに表示(セット)されている'do
     expect(page).to have_field'list[title]',with:list.title
     expect(page).to have_field'list[body]',with:list.body
   end
   it'保存ボタンが表示される'do
     expect(page).to have_button'保存'
   end
 end
context'更新処理に関するテスト'do
  it'更新後のリダイレクト先は正しいか'do
    fill_in'list[title]',with:Faker::Lorem.characters(number:5)
    fill_in'list[body]',with:Faker::Lorem.characters(number:20)
    click_button'保存'
    expect(page).to have_current_path todolist_path(list)
  end
end
end
end