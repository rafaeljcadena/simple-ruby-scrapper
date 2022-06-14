require 'bundler/inline'
require 'open-uri'

gemfile do
  source 'https://rubygems.org'

  gem 'nokogiri'
  gem 'pry'
end

doc = Nokogiri::HTML(URI.open('https://pe.olx.com.br/grande-recife/recife/madalena/imoveis/aluguel/3-quartos?sf=1'))

(1..20).each do |i|
  xpath_root = "//*[@id=\"ad-list\"]/li[#{i}]"

  title = nil
  doc.xpath("#{xpath_root}/div/a/div/div[2]/div[1]/div[1]/div[1]/h2").each do |link|
    title = link.content
  end

  price = nil
  doc.xpath("#{xpath_root}/div/a/div/div[2]/div[1]/div[2]/div/div/div[1]/span").each do |link|
    price = link.content
  end

  url = nil
  doc.xpath("#{xpath_root}/div/a").each do |link|
    url = link.attributes['href']&.value
  end

  next if url.nil?

  puts title
  puts "Valor: #{price}"
  puts "Link: #{url}"
  puts ''
end
