class AddAdmin < ActiveRecord::Migration[6.0]
  def change
    User.create!(email: 'q@q.q', password: '111111', admin: true)
  end
end
