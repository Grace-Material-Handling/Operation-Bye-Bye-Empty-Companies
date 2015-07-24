# app.rb

# Login to nutshell.
$nutshell = NutshellCrmAPI::Client.new($username, $apiKey)


# Get all companies in nutshell.
companies = []
i = 0
loop do
	i+=1
	response = $nutshell.find_accounts([], nil, nil, 100, i, false)
	break if response.length == 0
	companies.concat(response)
end


# Filter companies that have no people
# associated with them.
companies_without_people = []
companies.each do |company|
	if company["contacts"].length == 0
		companies_without_people.push(company)
	end
end


# Create spreadsheet with missing companies.
CSV.open("companies_without_people.csv", "wb") do |csv|
	csv << ["Company"]
	companies_without_people.each do |company|
		csv << [].push(company["name"])
	end
end


# Print message to Jenkins
puts "You have #{companies_without_people.length} companies without people."