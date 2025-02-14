require 'faker'
require 'csv'
require_relative 'product'
require_relative 'simple_product'
if ARGV.empty?
	puts "Usage: ruby faker_script.rb [n]"
	puts "n: number of products to genetate"
elsif ARGV[0].to_i == 0
	puts "Usage: ruby faker_script.rb [n]"
	puts "where n = number of products to genetate"
else
	count = ARGV[0].to_i
	CSV.open('shopify_data.csv', 'wb') do |csv|
		product = Product.new({})
		csv << product.headers
		count.times do 
			sizes = [Faker::Commerce.unique.color,Faker::Commerce.unique.color]
			defaultsize = Faker::Commerce.unique.color
			Faker::Commerce.unique.clear
			product = Product.new({option1_value: defaultsize, option1_name: 'Color'})
			csv << product.attributes
			sizes.each do |size|
				csv << product.simple_product_attributes(size)
			end
		end
		puts 'done'
	end
end
