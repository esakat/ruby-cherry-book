require 'csv'

CSV.open('./sample_folder/sample.csv', 'w') do |csv|
  # ヘッダー追加
  csv << ['Name', 'Age']
  # 値を追加
  csv << ['Alice', 12]
end

CSV.foreach('./sample_folder/sample.csv', col_sep: "\t") do |row|
  puts "1: #{row[0]}, 2: #{row[1]}"
end


require 'json'

user = { name: 'Alice', age: 12 }

user_json = user.to_json
puts user_json

puts JSON.parse(user_json)

require 'yaml'

yaml = <<TEXT
alice:
  name: 'Alice'
  age: 12
TEXT

users = YAML.load(yaml)

users['alice']['gender'] = :female

puts YAML.dump(users)

# =>
# {"name":"Alice","age":12}
# {"name"=>"Alice", "age"=>12}
# ---
# alice:
#   name: Alice
#   age: 12
#   gender: :female