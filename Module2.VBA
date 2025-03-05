import csv
import os
# Files to load and output (update with correct file paths)
budget_data = os.path.join("Resources", "budget_data.csv")  # Input file path
file_to_output = os.path.join("analysis", "budget_analysis.txt")  # Output file path
# Define variables to track the financial data
total_months = 0
total_net = 0
# Add more variables to track other necessary financial data
month_of_change = []
net_change_list = []
greatest_increase = ["", 0]
greatest_decrease = ["", 999999999]
# Open and read the csv
with open(budget_data) as financial_data:
    reader = csv.reader(financial_data)
    # Skip the header row
    header = next(reader)
    # Extract first row to avoid appending to net_change_list
    first_row = next(reader)
    # Track the total and net change
    total_months +=1
    total_net +=int(first_row[1])
    previous_net = int(first_row[1])
    # Process each row of data
    for row in reader:
        # Track the total months
        total_months +=1
        total_net +=int(row[1])
        # Track the net total
        net_change = int(row[1]) - previous_net
        previous_net = int(row[1])
        net_change_list +=[net_change]
        month_of_change +=[row[0]]
        # Calculate the greatest increase in profits (month and amount)
        if net_change > greatest_increase[1]:
            greatest_increase[0] = row[0]
            greatest_increase[1] = net_change
        # Calculate the greatest decrease in losses (month and amount)
        if net_change < greatest_decrease[1]:
            greatest_decrease[0] = row[0]
            greatest_decrease[1] = net_change
# Calculate the average net change across the months
monthly_average = sum(net_change_list)/len(net_change_list)
# Generate the output summary
output = (
    f"Financial Analysis\n"
    f"----------------------------\n"
    f"Total Months: {total_months}\n"
    f"Total: ${total_net}\n"
    f"Average Change: ${monthly_average:.2f}\n"
    f"Greatest Increase in Profits: {greatest_increase[0]} (${greatest_increase[1]})\n"
    f"Greatest Decrease in Profits: {greatest_decrease[0]} (${greatest_decrease[1]})\n"
)
# Print the output
print(output)
#Write the results to a text file
with open(file_to_output, "w") as txt_file:
    txt_file.write(output)
10:24
# Import necessary modules
import csv
import os
# Files to load and output (update with correct file paths)
file_to_load = os.path.join("Resources", "election_data.csv")  # Input file path
file_to_output = os.path.join("analysis", "election_analysis.txt")  # Output file path
# Initialize variables to track the election data
total_votes = 0  # Track the total number of votes cast
# Define lists and dictionaries to track candidate names and vote counts
candidate_name = []
vote_counts = {}
# Winning Candidate and Winning Count Tracker
winning_candidate = ""
winning_count = 0
# Open the CSV file and process it
with open(file_to_load) as election_data:
    reader = csv.reader(election_data)
    # Skip the header row
    header = next(reader)
    # Loop through each row of the dataset and process it
    for row in reader:
        # Print a loading indicator (for large datasets)
        #print(". ", end="")
        # Increment the total vote count for each row
        total_votes +=1
        # Get the candidate's name from the row
        name = row[2]
        # If the candidate is not already in the candidate list, add them
        if name not in candidate_name:
            candidate_name.append(name)
            vote_counts[name]=0
        # Add a vote to the candidate's count
        vote_counts[name]+=1
# Open a text file to save the output
with open(file_to_output, "w") as txt_file:
    # Print the total vote count (to terminal)
    output_1 =  (
        f'Election Results\n'
        f'------------------------\n'
        f'Total Votes: {total_votes}\n'
        f'------------------------\n')
    print(output_1)
    # Write the total vote count to the text file
    txt_file.write(output_1)
    # Loop through the candidates to determine vote percentages and identify the winner
    for candidate in vote_counts:
        # Get the vote count and calculate the percentage
        vote = vote_counts[candidate]
        vote_percentage = float(vote)/float(total_votes)*100
        #{candidate_name:(vote_counts/total_votes)*100}
        # Update the winning candidate if this one has more votes
        if vote>winning_count:
            winning_count = vote
            winning_candidate = candidate
        # Print and save each candidate's vote count and percentage
        candidate_summary = f'{candidate}: {vote_percentage:.2f}% ({vote})\n'
        #print(vote_percentage[candidate_name], (candidate[candidate_name]))
        print(candidate_summary)
        txt_file.write(candidate_summary)
    # Generate and print the winning candidate summary
    output = (
    f'------------------------\n'
    f'Winning Candidate: {winning_candidate}\n'
    f'-------------------------\n')
    print(output)
    # Save the winning candidate summary to the text file
    txt_file.write(output)
