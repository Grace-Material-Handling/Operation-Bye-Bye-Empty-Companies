# app.rb

# login to nutshell
$nutshell = NutshellCrmAPI::Client.new($username, $apiKey)


companies = []
i = 0
loop do
	i+=1
	response = $nutshell.find_accounts([], nil, nil, 100, i, false)
	break if response.length == 0
	companies.concat(response)
end



companies_without_people = []
companies.each do |company|
	if company["contacts"].length == 0
		companies_without_people.push(company)
	end
end


puts "You have #{companies_without_people.length} companies without people."