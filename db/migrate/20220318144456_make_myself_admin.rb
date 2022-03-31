class MakeMyselfAdmin < ActiveRecord::Migration[6.1]
  def change
    User.find_by(email: 'v.kozyrev.sa@gmail.com')&.update(admin: true)
  end
end
