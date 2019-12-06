class AddThemeToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :theme, :string
  end
end
