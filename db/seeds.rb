# coding: utf-8
require "csv"

Prefectural.delete_all # 重複するとERRORになる為、seedの度に再作成している。
namelist = Array.new
CSV.foreach('db/prefecturals_name_seed.csv') do |row|
  record = {
    :id              => row[0].to_i,
    :name            => row[1],
  }
  p record
  name = Prefectural.create!(record)
  namelist[name.id] = name # 配列でオブジェクトを退避
end

Area.delete_all
connection = ActiveRecord::Base.connection

sql = File.read('db/area_data.sql')
statements = sql.split(/;$/)
statements.pop

ActiveRecord::Base.transaction do
  statements.each do |statement|
    connection.execute(statement)
  end
end
